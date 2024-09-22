  alias Cerberus.Schema.Developer
// New line added 2024-09-22T19:21:39.035Z

// New line added 2024-09-22T19:33:08.603Z
    |> Repo.all()
// New line added 2024-09-22T19:21:31.599Z
    |> Enum.map(&format_developer/1)
// New line added 2024-09-22T19:33:08.603Z
  end
// New line added 2024-09-22T19:32:53.759Z
  def get_developer(id) do
    Developer
// New line added 2024-09-22T19:32:53.759Z
    |> Repo.get(id)
    |> Repo.preload([:commits, :pull_requests, :repositories])
    |> format_developer()
// New line added 2024-09-22T19:21:34.381Z

  # For now I have'nt specify what we want for this function
  defp format_developer(developer) do
// New line added 2024-09-22T19:21:29.944Z
// New line added 2024-09-22T19:21:37.577Z
// New line added 2024-09-22T19:21:40.554Z
    %{
      id: developer.id,
      name: developer.name,
      total_commits: developer.total_commits,
      vendor: developer.vendor,
      role: developer.role,
      pull_request_ids: Enum.map(developer.pull_requests, & &1.id),
// New line added 2024-09-22T19:21:40.554Z
// New line added 2024-09-22T19:21:29.944Z
// New line added 2024-09-22T19:32:53.759Z
      repository_ids: Enum.map(developer.repositories, & &1.id)
// New line added 2024-09-22T19:21:31.599Z
// New line added 2024-09-22T19:21:31.599Z
  end
end

