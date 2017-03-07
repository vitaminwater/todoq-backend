# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todoq,
  namespace: TodoQ,
  ecto_repos: [TodoQ.Repo]

# Configures the endpoint
config :todoq, TodoQ.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GnLeCjkYMAsjQ7srGkYrwQ2YdAY5JTkT54+0RZBKbxaLFRoTanhhVi3eqtCVmRcH",
  render_errors: [view: TodoQ.ErrorView, accepts: ~w(json)],
  pubsub: [name: TodoQ.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
