defmodule Cerberus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CerberusWeb.Telemetry,
      Cerberus.Repo,
      {DNSCluster, query: Application.get_env(:cerberus, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cerberus.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Cerberus.Finch},
      # Start a worker by calling: Cerberus.Worker.start_link(arg)
      # {Cerberus.Worker, arg},
      # Start to serve requests, typically the last entry
      CerberusWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cerberus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CerberusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
