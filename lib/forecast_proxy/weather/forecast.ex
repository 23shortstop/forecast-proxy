defmodule ForecastProxy.Weather.Forecast do
  alias ForecastProxy.DarkSky

  @currently_and_daily_query [exclude: "[minutely,hourly,alerts,flags]"]

  @spec currently_and_daily(DarkSky.Client.coordinates()) :: DarkSky.Client.result()
  def currently_and_daily(coordinates) do
    DarkSky.Client.forecast(coordinates, @currently_and_daily_query)
  end
end
