defmodule Cerberus.Repo.Migrations.CreateDevelopersRepositories do
  use Ecto.Migration

  def change do
    create table(:developer_repositories) do
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
      add :repository_id, references(:repositories, on_delete: :delete_all), null: false
      add :role, :string
      add :joined_at, :utc_datetime, null: false, default: fragment("NOW()")

      timestamps()
    end

    create index(:developer_repositories, [:developer_id])
    create index(:developer_repositories, [:repository_id])
    create unique_index(:developer_repositories, [:developer_id, :repository_id])
  end
end
