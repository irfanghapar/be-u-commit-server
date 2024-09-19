defmodule Cerberus.Schema.Developer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "developers" do
    field :email, :string
    field :name, :string
    field :total_commits, :integer, default: 0
    field :vendor, :boolean, default: false
    field :role, :string

    has_many :commits, Cerberus.Schema.Commit
    has_many :pull_requests, Cerberus.Schema.PullRequest
    has_many :lines_changes, Cerberus.Schema.LinesAddedDeleted
    has_many :developer_repositories, Cerberus.Schema.DeveloperRepository
    many_to_many :repositories, Cerberus.Schema.Repository, join_through: Cerberus.Schema.DeveloperRepository

    timestamps()
  end

  def changeset(developer, attrs) do
    developer
    |> cast(attrs, [:email, :name, :total_commits, :vendor, :role])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
  end
end
