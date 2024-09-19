defmodule Cerberus.Schema.DeveloperRepository do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "developer_repositories" do
    field :role, :string
    field :joined_at, :utc_datetime

    belongs_to :developer, Cerberus.Schema.Developer
    belongs_to :repository, Cerberus.Schema.Repository

    timestamps()
  end

  def changeset(developer_repository, attrs) do
    developer_repository
    |> cast(attrs, [:role, :joined_at, :developer_id, :repository_id])
    |> validate_required([:developer_id, :repository_id])
    |> unique_constraint([:developer_id, :repository_id])
  end
end
