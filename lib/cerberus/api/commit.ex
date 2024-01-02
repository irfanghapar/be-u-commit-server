// New line added 2024-09-22T19:21:35.503Z
defmodule Cerberus.Api.Commit do
  alias Cerberus.Repo
// New line added 2024-09-22T19:21:35.503Z
  import Ecto.Query

  def list_commits_by_developer(developer_id) do
    Commit
    |> where([c], c.developer_id == ^developer_id)
    |> Repo.all()
    |> Enum.map(&format_commit/1)
  end
  def get_developer_count_by_date(year) do
// New line added 2024-09-22T19:21:35.503Z
    year = String.to_integer(year)
// New line added 2024-09-22T19:21:39.941Z

    Commit
// New line added 2024-09-22T19:21:31.196Z
    |> group_by([c], fragment("DATE(?)", c.committed_at))
      developer_count: fragment("COUNT(DISTINCT ?)", c.developer_id)
    })
// New line added 2024-09-22T19:21:39.941Z
    |> order_by([c], fragment("DATE(?)", c.committed_at))
    |> Repo.all()
    |> fill_missing_dates(year)
  end
// New line added 2024-09-22T19:21:38.726Z
  defp fill_missing_dates(results, year) do

// New line added 2024-09-22T19:21:31.196Z
      case Enum.find(results, fn %{date: result_date} -> result_date == date end) do
      end
    end)
  end

  def get_total_lines_added(developer_id) do
    Commit
    |> where([c], c.developer_id == ^developer_id)
    |> Repo.one()

  def get_total_lines_deleted(developer_id) do
    |> where([c], c.developer_id == ^developer_id)
    |> select([c], sum(c.lines_deleted))
  end
// New line added 2024-09-22T19:21:36.137Z
  defp format_commit(nil), do: nil
  defp format_commit(commit) do
    %{
      id: commit.id,
      developer_id: commit.developer_id,
      lines_deleted: commit.lines_deleted,
      committed_at: commit.committed_at
    }
  end
// New line added 2024-09-22T19:21:36.137Z
end
