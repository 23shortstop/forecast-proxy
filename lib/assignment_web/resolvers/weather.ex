defmodule AssignmentWeb.Resolvers.Weather do
  alias Assignment.Weather.Forecast
  alias AssignmentWeb.ForecastView

  def forecast(_parent, %{input: %{latitude: latitude, longitude: longitude}}, _resolution) do
    with {:ok, forecast} <- Forecast.currently_and_daily(latitude, longitude) do
      {:ok, ForecastView.render("forecast", %{forecast: forecast})}
    end
  end
end
