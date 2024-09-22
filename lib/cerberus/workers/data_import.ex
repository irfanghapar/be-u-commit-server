defmodule Cerberus.Workers.DataImport do
  alias Cerberus.Repo
  alias Cerberus.Schema.{Developer, Repository, Commit, DeveloperRepository, LinesAddedDeleted}
  import Ecto.Query
  require Logger

  @csv_files [
    "lib/cerberus/workers/data/cdx-android-app.csv",
    "lib/cerberus/workers/data/cdx-platform-web.csv"
  ]

  def import_data do
    @csv_files
    |> Enum.flat_map(&process_file/1)
    |> Enum.each(&process_commit/1)
  end

  defp process_file(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(parse_commit_line(&1, file_path)))
    |> Stream.filter(&(&1 != nil))
    |> Enum.to_list()
  end

  defp parse_commit_line(line, file_path) do
    case Regex.run(~r/^(\w+) Developer: (.*) \((.*)\) Date: (.*) Lines Added: (\d+) Lines Deleted: (\d+)$/, line) do
      [_, hash, developer_name, developer_email, date_str, lines_added, lines_deleted] ->
        case parse_date(date_str) do
          {:ok, date} ->
            %{
              hash: hash,
              developer_name: developer_name,
              developer_email: developer_email,
              date: date,
              lines_added: parse_lines(lines_added),
              lines_deleted: parse_lines(lines_deleted),
              repository_name: extract_repository_name(file_path)
            }
          {:error, _} ->
            Logger.error("Invalid date format: #{date_str}")
            nil
        end
      _ -> nil
    end
  end

  defp extract_repository_name(file_path) do
    file_path
    |> Path.basename(".csv")
    |> String.replace("-", " ")
  end

  defp parse_lines(lines) do
    case lines do
      "inf" -> Decimal.new("Infinity")
      _ -> Decimal.new(lines)
    end
  end

  defp parse_date(date_str) do
    case NaiveDateTime.from_iso8601(date_str) do
      {:ok, naive_date} ->
        {:ok, DateTime.from_naive!(naive_date, "Etc/UTC") |> DateTime.truncate(:second)}
      {:error, _} ->
        case parse_custom_date_format(date_str) do
          {:ok, naive_date} ->
            {:ok, DateTime.from_naive!(naive_date, "Etc/UTC") |> DateTime.truncate(:second)}
          {:error, _} ->
            {:error, :invalid_format}
        end
    end
  end

  defp parse_custom_date_format(date_str) do
    case Regex.run(~r/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/, date_str) do
      [_, year, month, day, hour, minute, second] ->
        NaiveDateTime.new(
          String.to_integer(year),
          String.to_integer(month),
          String.to_integer(day),
          String.to_integer(hour),
          String.to_integer(minute),
          String.to_integer(second)
        )
      _ -> {:error, :invalid_format}
    end
  end

  defp process_commit(commit_data) do
    Repo.transaction(fn ->
      developer = upsert_developer(commit_data)
      repository = upsert_repository(commit_data.repository_name)
      upsert_developer_repository(developer, repository)
      commit = create_commit(developer, repository, commit_data)
      create_lines_changed(developer, commit, commit_data)
    end)
  end

  defp upsert_developer(commit_data) do
    Repo.insert!(
      %Developer{
        email: commit_data.developer_email,
        name: commit_data.developer_name,
        total_commits: 1,
        role: "Developer"  # Ensure this is a string
      },
      on_conflict: [inc: [total_commits: 1]],
      conflict_target: :email
    )
  end

  defp upsert_repository(name) do
    Repo.insert!(
      %Repository{
        name: name,
        total_commits: 1
      },
      on_conflict: [inc: [total_commits: 1]],
      conflict_target: :name
    )
  end

  defp upsert_developer_repository(developer, repository) do
    Repo.insert!(
      %DeveloperRepository{
        developer_id: developer.id,
        repository_id: repository.id,
        role: "Developer",  # Ensure this is a string
        joined_at: DateTime.utc_now() |> DateTime.truncate(:second)  # Corrected joined_at field to DateTime in UTC without microseconds
      },
      on_conflict: :nothing,
      conflict_target: [:developer_id, :repository_id]
    )
  end

  defp create_commit(developer, repository, commit_data) do
    Repo.insert!(%Commit{
      developer_id: developer.id,
      repository_id: repository.id,
      lines_added: commit_data.lines_added,
      lines_deleted: commit_data.lines_deleted,
      committed_at: commit_data.date  # Ensure this is a DateTime in UTC without microseconds
    })
  end

  defp create_lines_changed(developer, commit, commit_data) do
    Repo.insert!(%LinesAddedDeleted{
      developer_id: developer.id,
      commit_id: commit.id,
      lines_added: commit_data.lines_added,
      lines_deleted: commit_data.lines_deleted
    })
  end
end
