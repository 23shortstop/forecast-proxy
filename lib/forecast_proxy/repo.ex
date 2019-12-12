defmodule ForecastProxy.Repo do
  use Ecto.Repo,
    otp_app: :forecast_proxy,
    adapter: Ecto.Adapters.Postgres
end
