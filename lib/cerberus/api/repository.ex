defmodule Cerberus.Api.Repository do
  alias Cerberus.Repo
  alias Cerberus.Schema.Repository
  alias Cerberus.Schema.Developer
  import Ecto.Query

  # Get a repository by ID
  def get_repository(id) do
    Repository
    |> Repo.get(id)
    |> Repo.preload([:commits, :developers])
    |> format_repository()
  end

  # Get all repositories for a specific developer
  def get_developer_repositories(developer_id) do
    query = from d in Developer,
      join: r in assoc(d, :repositories),
      where: d.id == ^developer_id,
      select: {r, d.total_commits},
      order_by: [desc: d.total_commits]

    case Repo.all(query) do
      [] -> {:error, :developer_not_found}
      repositories -> {:ok, Enum.map(repositories, &format_developer_repository/1)}
    end
  end

  # Simplified format for developer's repositories
  defp format_developer_repository({repository, total_commits}) do
    %{
      id: repository.id,
      name: repository.name,
      total_commits: total_commits,
      last_sync: repository.last_sync,
      inserted_at: repository.inserted_at,
      updated_at: repository.updated_at
    }
  end

  # Keep the original format_repository/1 for other use cases
  defp format_repository(nil), do: nil
  defp format_repository(repository) do
    %{
      id: repository.id,
      name: repository.name,
      total_commits: repository.total_commits,
      last_sync: repository.last_sync,
      inserted_at: repository.inserted_at,
      updated_at: repository.updated_at,
      commit_ids: Enum.map(repository.commits, & &1.id),
      developer_ids: Enum.map(repository.developers, & &1.id)
    }
  end
end
