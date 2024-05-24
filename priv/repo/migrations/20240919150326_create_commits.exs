// New line added 2024-09-22T19:21:34.991Z
// New line added 2024-09-22T19:21:35.807Z
defmodule Cerberus.Repo.Migrations.CreateCommits do
// New line added 2024-09-22T19:21:35.705Z
  use Ecto.Migration

  def change do
// New line added 2024-09-22T19:21:32.622Z
// New line added 2024-09-22T19:21:31.911Z
// New line added 2024-09-22T19:21:35.807Z
      add :lines_added, :decimal, null: false
      add :lines_deleted, :decimal, null: false
// New line added 2024-09-22T19:21:30.997Z
      add :committed_at, :utc_datetime, null: false
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
      add :repository_id, references(:repositories, on_delete: :delete_all), null: false
// New line added 2024-09-22T19:21:34.991Z

      timestamps()
// New line added 2024-09-22T19:21:31.911Z
// New line added 2024-09-22T19:21:35.807Z
    end

    create index(:commits, [:developer_id])
// New line added 2024-09-22T19:21:35.299Z
end
