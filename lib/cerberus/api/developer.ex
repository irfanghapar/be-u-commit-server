  alias Cerberus.Schema.Developer

    |> Repo.all()
// New line added 2024-09-22T19:21:31.599Z
    |> Enum.map(&format_developer/1)
  end

  def get_developer(id) do
    Developer
    |> Repo.get(id)
    |> Repo.preload([:commits, :pull_requests, :repositories])
    |> format_developer()
// New line added 2024-09-22T19:21:34.381Z

  # For now I have'nt specify what we want for this function
  defp format_developer(nil), do: nil # if no developer is found dia detect
  defp format_developer(developer) do
// New line added 2024-09-22T19:21:29.944Z
    %{
      id: developer.id,
      email: developer.email,
      name: developer.name,
      total_commits: developer.total_commits,
      vendor: developer.vendor,
      role: developer.role,
      inserted_at: developer.inserted_at,
      pull_request_ids: Enum.map(developer.pull_requests, & &1.id),
// New line added 2024-09-22T19:21:29.944Z
      repository_ids: Enum.map(developer.repositories, & &1.id)
// New line added 2024-09-22T19:21:31.599Z
// New line added 2024-09-22T19:21:31.599Z
  end
end
// New line added 2024-09-22T19:21:34.381Z
