# Cerberus


## Running the Application

To run the application, you need to have Elixir, Erlang, and Phoenix installed. We recommend using `asdf` version manager to manage your Elixir and Erlang versions.

Here are the steps to run the application:

1. Install the required Elixir and Erlang versions using `asdf`. You can find the required versions in the `.tool-versions` file in the root of the project.

```bash
asdf install
```

2. Install the project dependencies:

```bash
mix deps.get
```

3. Setup the database:

```bash
mix ecto.setup
```

4. To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## Testing

To run the tests for the application, use the following command:

```bash
mix test
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
