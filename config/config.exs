# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bell,
  ecto_repos: [Bell.Repo]

# Configures the endpoint
config :bell, BellWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EnRugJiRPWPUD+j9Eesf30gjdB21HTeIyVZi4BPi7zvLmc0+J6sC7xakyKgzuSai",
  render_errors: [view: BellWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bell.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "2MZl9TEJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :hammer,
  backend: {Hammer.Backend.ETS, [expiry_ms: 60_000 * 60 * 4, cleanup_interval_ms: 60_000 * 10]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
