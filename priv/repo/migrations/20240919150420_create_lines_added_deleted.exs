defmodule Cerberus.Repo.Migrations.CreateLinesAddedDeleted do
  use Ecto.Migration

  def change do
    create table(:lines_added_deleted) do
      add :lines_added, :decimal, null: false
      add :lines_deleted, :decimal, null: false
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
      add :commit_id, references(:commits, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:lines_added_deleted, [:developer_id])
    create index(:lines_added_deleted, [:commit_id])
  end
end
