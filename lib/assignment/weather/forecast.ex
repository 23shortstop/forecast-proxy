defmodule Assignment.Weather.Forecast do
  alias Assignment.DarkSky

  @type body :: %{required(String.t()) => any()}
  @type result :: {:ok, body} | {:error, String.t()}

  @currently_and_daily_query [exclude: "[minutely,hourly,alerts,flags]"]

  @spec currently_and_daily(%Decimal{}, %Decimal{}) :: result
  def currently_and_daily(latitude, longitude) do
    DarkSky.Client.forecast(latitude, longitude, @currently_and_daily_query)
  end
end
