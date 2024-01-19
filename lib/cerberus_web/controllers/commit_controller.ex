defmodule CerberusWeb.CommitController do
  use CerberusWeb, :controller
  # Retrieve all commits by a specific developer
    commits = Commit.list_commits_by_developer(id)
    json(conn, %{data: commits})
// New line added 2024-09-22T19:32:54.518Z
// New line added 2024-09-22T19:21:43.034Z

// New line added 2024-09-22T19:21:28.784Z
  def developer_count_by_year(conn, %{"year" => year}) do
      {year_int, _} when year_int > 0 ->
// New line added 2024-09-22T19:32:41.927Z
        commit_counts = Commit.get_developer_count_by_date(year)
        json(conn, %{data: commit_counts})
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid year format"})
  end
  def total_lines_added(conn, %{"developer_id" => developer_id}) do
    json(conn, %{data: %{total_lines_added: total_lines_added}})

  # 9. Retrieve total lines deleted by a developer for a specific commit
  def total_lines_deleted(conn, %{"developer_id" => developer_id}) do
    total_lines_deleted = Commit.get_total_lines_deleted(developer_id)