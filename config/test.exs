use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :forecast_proxy, ForecastProxyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :tesla, adapter: Tesla.Mock

config :forecast_proxy,
  dark_sky_key: "test_key",
  caching_time: 1000
