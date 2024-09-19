defmodule Cerberus.Schema.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :name, :string
    field :total_commits, :integer, default: 0
    field :last_sync, :utc_datetime

    has_many :commits, Cerberus.Schema.Commit
    has_many :pull_requests, Cerberus.Schema.PullRequest
    has_many :developer_repositories, Cerberus.Schema.DeveloperRepository
    many_to_many :developers, Cerberus.Schema.Developer, join_through: Cerberus.Schema.DeveloperRepository

    timestamps()
  end

  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :total_commits, :last_sync])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
