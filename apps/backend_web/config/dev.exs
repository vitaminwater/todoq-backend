use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :backend_web, Backend.Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :guardian, Guardian,
  secret_key: "wx5mU4F2sa+WOqrBfZSI5N7XwmdeaIkpzuoBWp8sjIxk68LN7d5hVQsAohQ7X9Oc"
