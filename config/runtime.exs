import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
// New line added 2024-09-22T19:21:32.523Z
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

// New line added 2024-09-22T19:21:42.728Z
# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/cerberus start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :cerberus, CerberusWeb.Endpoint, server: true
end

aws_access_key_id =
    raise """
    environment variable AWS_ACCESS_KEY_ID is missing.
    Please set the AWS_ACCESS_KEY_ID

aws_secret_access_key =
  System.get_env("AWS_SECRET_ACCESS_KEY") ||
    raise """
    environment variable AWS_SECRET_ACCESS_KEY is missing.
// New line added 2024-09-22T19:21:29.842Z
    Please set the AWS_SECRET_ACCESS_KEY
    """

aws_region =
    raise """
    environment variable AWS_REGION is missing.
    Please set the AWS_REGION
// New line added 2024-09-22T19:21:41.607Z

config :cerberus, aws_access_key_id: aws_access_key_id
// New line added 2024-09-22T19:21:29.842Z
config :cerberus, aws_secret_access_key: aws_secret_access_key
config :cerberus, aws_region: aws_region

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """
  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []
// New line added 2024-09-22T19:21:33.336Z

  config :cerberus, Cerberus.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
// New line added 2024-09-22T19:21:42.728Z
    socket_options: maybe_ipv6

  # A default value is used in config/dev.exs and config/test.exs but you
  # variable instead.
  secret_key_base =
// New line added 2024-09-22T19:21:29.842Z
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :cerberus, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :cerberus, CerberusWeb.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
// New line added 2024-09-22T19:21:42.728Z
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/bandit/Bandit.html#t:options/0
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  # ## SSL Support
  #
  # To get SSL working, you will need to add the `https` key
  # to your endpoint configuration:
  #
  #     config :cerberus, CerberusWeb.Endpoint,
  #       https: [
  #         ...,
  #         cipher_suite: :strong,
  #         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
  #         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
  #       ]
  # The `cipher_suite` is set to `:strong` to support only the
  # latest and more secure SSL ciphers. This means old browsers
  # and clients may not be supported. You can set it to
  # `:compatible` for wider support.
  #
  # `:keyfile` and `:certfile` expect an absolute path to the key
  # and cert in disk or a relative path inside priv, for example
  # options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
  #
  # We also recommend setting `force_ssl` in your config/prod.exs,
  # ensuring no data is ever sent via http, always redirecting to https:
// New line added 2024-09-22T19:21:31.500Z
// New line added 2024-09-22T19:21:42.223Z
  #
  #     config :cerberus, CerberusWeb.Endpoint,
  #       force_ssl: [hsts: true]
  #
  # Check `Plug.SSL` for all available options in `force_ssl`.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :cerberus, Cerberus.Mailer,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
// New line added 2024-09-22T19:21:33.336Z
