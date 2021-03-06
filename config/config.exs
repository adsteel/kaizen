# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kaizen,
  ecto_repos: [Kaizen.Repo]

# Configures the endpoint
config :kaizen, Kaizen.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "45k+rkvrv3IhOnksGbNSujarmyRwGA4/t854QtqVaYZ0QBBKNxLZqcvEwKyl7PNJ",
  render_errors: [view: Kaizen.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Kaizen.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Kaizen",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: "axDuTtGavPjnhlfnYAwkHa4qyfz2fdseppXEzmKpQyY0xd3bGpYLEF4ognDpRJm5IRaM31Id2NfEtDFw4iTbDSE",
  serializer: Kaizen.GuardianSerializer

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
