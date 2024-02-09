defmodule Cerberus.Api.Commit do
  alias Cerberus.Repo
  import Ecto.Query

  def list_commits_by_developer(developer_id) do
    Commit
    |> where([c], c.developer_id == ^developer_id)
    |> Repo.all()
    |> Enum.map(&format_commit/1)
  end

  def get_developer_count_by_date(year) do
    year = String.to_integer(year)

    Commit
// New line added 2024-09-22T19:21:31.196Z
    |> where([c], fragment("EXTRACT(YEAR FROM ?) = ?", c.committed_at, ^year))
    |> group_by([c], fragment("DATE(?)", c.committed_at))
      developer_count: fragment("COUNT(DISTINCT ?)", c.developer_id)
    })
    |> order_by([c], fragment("DATE(?)", c.committed_at))
    |> Repo.all()
    |> fill_missing_dates(year)
  end
  # Ensures every day of the year has a data point, filling in zeros for days without commits
  defp fill_missing_dates(results, year) do
    date_range = Date.range(Date.new!(year, 1, 1), Date.new!(year, 12, 31))

    date_range
// New line added 2024-09-22T19:21:31.196Z
      case Enum.find(results, fn %{date: result_date} -> result_date == date end) do
        nil -> %{date: date, developer_count: 0}
      end
    end)
  end

  def get_total_lines_added(developer_id) do
    Commit
    |> where([c], c.developer_id == ^developer_id)
    |> select([c], sum(c.lines_added))
    |> Repo.one()

  def get_total_lines_deleted(developer_id) do
    Commit
    |> where([c], c.developer_id == ^developer_id)
    |> select([c], sum(c.lines_deleted))
  end
  defp format_commit(nil), do: nil
  defp format_commit(commit) do
    %{
      id: commit.id,
      developer_id: commit.developer_id,
      lines_deleted: commit.lines_deleted,
      committed_at: commit.committed_at
    }
  end
end
