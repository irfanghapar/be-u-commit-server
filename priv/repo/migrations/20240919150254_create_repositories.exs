defmodule Cerberus.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string, null: false
      add :total_commits, :integer, default: 0
      add :last_sync, :utc_datetime

      timestamps()
    end

    create unique_index(:repositories, [:name])
  end
end
