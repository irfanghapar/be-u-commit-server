defmodule Cerberus.Repo.Migrations.CreatePullRequests do
  use Ecto.Migration

  def change do
    create table(:pull_requests) do
      add :pr_number, :integer, null: false
      add :title, :string, null: false
      add :developer_id, references(:developers, on_delete: :delete_all), null: false
      add :repository_id, references(:repositories, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:pull_requests, [:developer_id])
    create index(:pull_requests, [:repository_id])
    create unique_index(:pull_requests, [:pr_number, :repository_id])
  end
end
