defmodule Cerberus.Repo.Migrations.CreateDevelopers do
  use Ecto.Migration

  def change do
    create table(:developers) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :total_commits, :integer, default: 0
      add :vendor, :boolean, default: false
      add :role, :string, default: "Developer"

      timestamps()
    end

    create unique_index(:developers, [:email])
  end
end
