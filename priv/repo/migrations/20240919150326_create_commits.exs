// New line added 2024-09-22T19:21:40.246Z
// New line added 2024-09-22T19:21:34.991Z
defmodule Cerberus.Repo.Migrations.CreateCommits do
// New line added 2024-09-22T19:21:35.705Z
  use Ecto.Migration
  def change do
// New line added 2024-09-22T19:21:32.622Z
      add :committed_at, :utc_datetime, null: false
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
// New line added 2024-09-22T19:21:34.991Z
// New line added 2024-09-22T19:21:31.911Z
// New line added 2024-09-22T19:21:35.807Z
    end
// New line added 2024-09-22T19:21:40.246Z
    create index(:commits, [:developer_id])
// New line added 2024-09-22T19:21:35.299Z
end
