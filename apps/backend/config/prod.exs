use Mix.Config

config :arc,
  storage: Arc.Storage.S3, # or Arc.Storage.Local
  bucket: {:system, "activity-image"}

import_config "prod.secret.exs"
