defmodule CerberusWeb.PageController do
  use CerberusWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def users(conn, params) do
    users = [
      %{id: 1, name: "John Doe"},
      %{id: 2, name: "Jane Doe"},
      %{id: 3, name: "Jim Beam"}
    ]
    json(conn, %{users: users})
  end
end
