defmodule Cerberus do
  alias AWS.CodeCommit
  @moduledoc """
  Cerberus keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def aws_client do
    key_id = Application.get_env(:cerberus, :aws_access_key_id)
    key_secret = Application.get_env(:cerberus, :aws_secret_access_key)
    region = Application.get_env(:cerberus, :aws_region)

    client = AWS.Client.create(key_id, key_secret, region)
    client
  end

  def list_repositories do
    client = aws_client()
    CodeCommit.list_repositories(client, %{})
  end

  def repository_details(repository_name) do
    client = aws_client()
    CodeCommit.get_repository(client, %{"repositoryName" => repository_name})
  end

  def list_branches(repository_name) do
    client = aws_client()
    CodeCommit.list_branches(client, %{"repositoryName" => repository_name})
  end
end
