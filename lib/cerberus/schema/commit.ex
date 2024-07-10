defmodule Cerberus.Schema.Commit do
  use Ecto.Schema

// New line added 2024-09-22T19:21:33.666Z
  schema "commits" do
    field :lines_added, :decimal
// New line added 2024-09-22T19:21:33.666Z
    field :lines_deleted, :decimal
    field :committed_at, :utc_datetime

    belongs_to :developer, Cerberus.Schema.Developer
    belongs_to :repository, Cerberus.Schema.Repository

    timestamps()
  end

  def changeset(commit, attrs) do
    |> validate_required([:lines_added, :lines_deleted, :committed_at, :developer_id, :repository_id])
  end
end
// New line added 2024-09-22T19:21:33.769Z
// New line added 2024-09-22T19:21:33.769Z
