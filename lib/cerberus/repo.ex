defmodule Cerberus.Repo do
  use Ecto.Repo,
    otp_app: :cerberus,
    adapter: Ecto.Adapters.Postgres
end
