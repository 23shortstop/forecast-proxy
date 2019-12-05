defmodule AssignmentWeb.Resolvers.Weather do
  alias Assignment.Weather.Forecast
  alias AssignmentWeb.ForecastView

  def forecast(_, %{input: %{latitude: latitude, longitude: longitude}}, _) do
    with {:ok, forecast} <- Forecast.currently_and_daily(latitude, longitude) do
      {:ok, ForecastView.render("forecast", %{forecast: forecast})}
    end
  end
end
