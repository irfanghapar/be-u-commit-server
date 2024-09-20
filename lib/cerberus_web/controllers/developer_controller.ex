defmodule CerberusWeb.DeveloperController do
  use CerberusWeb, :controller
  alias Cerberus.Api.Developer

  # 1. Retrieve the list of developers
  def index(conn, _params) do
    developers = Developer.list_developers()
    json(conn, developers)
  end

  # 2. Get details of a specific developer by ID
  def show(conn, %{"id" => id}) do
    case Developer.get_developer(id) do
      nil -> send_resp(conn, :not_found, "Developer not found")
      developer -> json(conn, developer)
    end
  end
end
