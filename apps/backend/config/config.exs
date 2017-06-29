use Mix.Config

config :backend, ecto_repos: [Backend.Repo]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "MyApp",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  serializer: MyApp.GuardianSerializer

import_config "#{Mix.env}.exs"
