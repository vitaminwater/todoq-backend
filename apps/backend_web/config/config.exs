# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :backend_web,
  namespace: Backend.Web,
  ecto_repos: [Backend.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :backend_web, Backend.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FaTh/j7+2mNa+wIfSFz+NcGo7lHdvbu1hibltSh+FRe6B8vAg+0TDerWCceaGt1z",
  render_errors: [view: Backend.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Backend.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :backend_web, :generators,
  context_app: :backend

config :guardian, Guardian,
  issuer: "MyApp",
  ttl: { 30, :days },
  allowed_drift: 2000,
  serializer: Backend.Web.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
