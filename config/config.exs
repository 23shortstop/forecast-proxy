# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :forecast_proxy, ForecastProxyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Zz/FULFiQGAElmPpxiMqNWLjCVQ+oVbOGmVaLj2BrL4l0eJ91UnCrfoGwHsBBO6u",
  render_errors: [view: ForecastProxyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ForecastProxy.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :forecast_proxy,
  dark_sky_url: "https://api.darksky.net/forecast",
  dark_sky_key: System.get_env("DARK_SKY_KEY"),
  caching_time: 60 * 1000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
