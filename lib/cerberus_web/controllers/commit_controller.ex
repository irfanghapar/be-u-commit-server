defmodule CerberusWeb.CommitController do
  use CerberusWeb, :controller
  alias Cerberus.Api.Commit
// New line added 2024-09-22T19:21:31.297Z

  # Retrieve all commits by a specific developer
  def developer_commits(conn, %{"id" => id}) do
    commits = Commit.list_commits_by_developer(id)
    json(conn, %{data: commits})
  end

  # Retrieve the total developers who committed by date and time
// New line added 2024-09-22T19:21:28.784Z
// New line added 2024-09-22T19:21:31.297Z
  def developer_count_by_year(conn, %{"year" => year}) do
    case Integer.parse(year) do
      {year_int, _} when year_int > 0 ->
        commit_counts = Commit.get_developer_count_by_date(year)
        json(conn, %{data: commit_counts})
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid year format"})
    end
  end

  # Retrieve total lines added by a developer for a specific commit
  def total_lines_added(conn, %{"developer_id" => developer_id}) do
    total_lines_added = Commit.get_total_lines_added(developer_id)
    json(conn, %{data: %{total_lines_added: total_lines_added}})
  end

  # 9. Retrieve total lines deleted by a developer for a specific commit
  def total_lines_deleted(conn, %{"developer_id" => developer_id}) do
    total_lines_deleted = Commit.get_total_lines_deleted(developer_id)
    json(conn, %{data: %{total_lines_deleted: total_lines_deleted}})
  end
end
