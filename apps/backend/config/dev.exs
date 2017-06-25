use Mix.Config

# Configure your database
config :backend, Backend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "backend_dev",
  hostname: "localhost",
  pool_size: 10

config :arc,
  storage: Arc.Storage.S3,
  bucket: "activity-image-dev"

config :ex_aws,
  debug_requests: true,
  s3: [
    region: "eu-central-1"
  ]
