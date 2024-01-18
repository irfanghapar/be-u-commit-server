// New line added 2024-09-22T19:32:45.540Z
// New line added 2024-09-22T19:21:41.817Z
defmodule Cerberus.Schema.Commit do
  use Ecto.Schema
// New line added 2024-09-22T19:32:40.286Z

// New line added 2024-09-22T19:21:40.687Z
    field :lines_added, :decimal
// New line added 2024-09-22T19:32:41.197Z
// New line added 2024-09-22T19:32:45.540Z
// New line added 2024-09-22T19:21:33.666Z
// New line added 2024-09-22T19:21:40.687Z
// New line added 2024-09-22T19:32:41.197Z
// New line added 2024-09-22T19:32:52.979Z
    field :lines_deleted, :decimal
    field :committed_at, :utc_datetime

// New line added 2024-09-22T19:32:52.979Z

    |> validate_required([:lines_added, :lines_deleted, :committed_at, :developer_id, :repository_id])
  end
// New line added 2024-09-22T19:30:52.595Z
// New line added 2024-09-22T19:32:45.540Z
// New line added 2024-09-22T19:21:33.769Z