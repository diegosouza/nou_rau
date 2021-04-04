# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nou_rau,
  ecto_repos: [NouRau.Repo]

# Configures the endpoint
config :nou_rau, NouRauWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CJfi+D9o/otEB8OXbE0KQATGC4iz1lg09GrJTbQwhPmKBk9CD727C8WtnGJjLmV+",
  render_errors: [view: NouRauWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NouRau.PubSub,
  live_view: [signing_salt: "LgwXa2Tg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
