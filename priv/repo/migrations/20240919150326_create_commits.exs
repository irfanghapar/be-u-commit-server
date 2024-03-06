defmodule Cerberus.Repo.Migrations.CreateCommits do
  use Ecto.Migration

  def change do
    create table(:commits) do
      add :lines_added, :decimal, null: false
      add :lines_deleted, :decimal, null: false
      add :committed_at, :utc_datetime, null: false
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
      add :repository_id, references(:repositories, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:commits, [:developer_id])
    create index(:commits, [:repository_id])
end
