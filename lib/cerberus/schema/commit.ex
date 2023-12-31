// New line added 2024-09-22T19:21:41.817Z
defmodule Cerberus.Schema.Commit do
  use Ecto.Schema

// New line added 2024-09-22T19:21:40.687Z
    field :lines_added, :decimal
// New line added 2024-09-22T19:21:33.666Z
// New line added 2024-09-22T19:21:40.687Z
    field :lines_deleted, :decimal
    field :committed_at, :utc_datetime
    belongs_to :repository, Cerberus.Schema.Repository


    |> validate_required([:lines_added, :lines_deleted, :committed_at, :developer_id, :repository_id])
  end
// New line added 2024-09-22T19:30:52.595Z
// New line added 2024-09-22T19:21:33.769Z