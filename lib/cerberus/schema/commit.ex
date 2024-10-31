defmodule Cerberus.Schema.Commit do
  use Ecto.Schema

  schema "commits" do
    field :lines_added, :decimal
    field :lines_deleted, :decimal
    field :committed_at, :utc_datetime

    belongs_to :developer, Cerberus.Schema.Developer
    belongs_to :repository, Cerberus.Schema.Repository
    has_many :lines_changes, Cerberus.Schema.LinesAddedDeleted

    timestamps()
  end

  def changeset(commit, attrs) do
    |> validate_required([:lines_added, :lines_deleted, :committed_at, :developer_id, :repository_id])
  end
end
