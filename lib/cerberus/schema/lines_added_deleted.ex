defmodule Cerberus.Schema.LinesAddedDeleted do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lines_added_deleted" do
    field :lines_added, :decimal
    field :lines_deleted, :decimal

    belongs_to :developer, Cerberus.Schema.Developer
    belongs_to :commit, Cerberus.Schema.Commit

    timestamps()
  end

  def changeset(lines_added_deleted, attrs) do
    lines_added_deleted
    |> cast(attrs, [:lines_added, :lines_deleted, :developer_id, :commit_id])
    |> validate_required([:lines_added, :lines_deleted, :developer_id, :commit_id])
    |> validate_number(:lines_added, greater_than_or_equal_to: 0)
    |> validate_number(:lines_deleted, greater_than_or_equal_to: 0)
  end
end
