defmodule Cerberus.Schema.PullRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pull_requests" do
    field :pr_number, :integer
    field :title, :string

    belongs_to :developer, Cerberus.Schema.Developer
    belongs_to :repository, Cerberus.Schema.Repository

    timestamps()
  end

  def changeset(pull_request, attrs) do
    pull_request
    |> cast(attrs, [:pr_number, :title, :developer_id, :repository_id])
    |> validate_required([:pr_number, :title, :developer_id, :repository_id])
  end
end
