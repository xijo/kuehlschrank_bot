# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :kuehlschrank, Kuehlschrank.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :arc,
  storage: Arc.Storage.S3, # or Arc.Storage.Local
  virtual_host: true,
  bucket: System.get_env("S3_BUCKET")

config :ex_aws,
  access_key_id: System.get_env("S3_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("S3_SECRET_ACCESS_KEY"),
  region: "eu-west-1",
  host: "s3.eu-west-1.amazonaws.com",
  s3: [
    scheme: "https://",
    host: "s3.eu-west-1.amazonaws.com",
    region: "eu-west-1",
  ]

config :kuehlschrank, :telegram_bot, System.get_env("TELEGRAM_BOT")

config :kuehlschrank, KuehlschrankWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :kuehlschrank, KuehlschrankWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
