# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# config :deimosSurface,
#   ecto_repos: [DeimosSurface.Repo]

# Configures the endpoint
config :deimosSurface, DeimosSurfaceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DeimosSurfaceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DeimosSurface.PubSub,
  live_view: [signing_salt: "2d5/Thgk"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :deimosSurface, DeimosSurface.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.14.0",
#   default: [
#     args:
#       ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :surface, :components, [
  {Surface.Components.Form.ErrorTag,
   default_translator: {DeimosSurfaceWeb.ErrorHelpers, :translate_error}}
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
