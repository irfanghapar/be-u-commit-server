defmodule CerberusWeb.RepoController do
  use CerberusWeb, :controller
  alias Cerberus.Api.Repository

  # Get details of a specific repository by ID
  def show(conn, %{"id" => id}) do
    case Repository.get_repository(id) do
      nil -> send_resp(conn, :not_found, "Repository not found")
      repository -> json(conn, repository)
    end
  end

  # Get all repositories for a specific developer
  def developer_repositories(conn, %{"id" => developer_id}) do
    case Repository.get_developer_repositories(developer_id) do
      {:ok, repositories} -> json(conn, repositories)
      {:error, :developer_not_found} -> send_resp(conn, :not_found, "No repositories found for this developer")
    end
  end
end
