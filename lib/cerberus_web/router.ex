defmodule CerberusWeb.Router do
  use CerberusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CerberusWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CerberusWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/users", PageController, :users
  end

  # Other scopes may use custom stacks.
  # scope "/api", CerberusWeb do
  #   pipe_through :api
  # end
  scope "/api", CerberusWeb do
    pipe_through :api

    get "/developers", DeveloperController, :index
    get "/developers/:id", DeveloperController, :show
    get "/repositories/:id", RepoController, :show
    get "/developer/:id/repositories", RepoController, :developer_repositories
    get "/commits/developer/:id", CommitController, :developer_commits
    get "/commits/developer_count/:year", CommitController, :developer_count_by_year
    get "/developers/:developer_id/total_lines_added", CommitController, :total_lines_added
    get "/developers/:developer_id/total_lines_deleted", CommitController, :total_lines_deleted
  end



  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cerberus, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CerberusWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
