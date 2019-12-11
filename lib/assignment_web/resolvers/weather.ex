defmodule AssignmentWeb.Resolvers.Weather do
  alias Assignment.Weather.Forecast

  def forecast(%{input: %{latitude: latitude, longitude: longitude}}, _) do
    Forecast.currently_and_daily({latitude, longitude})
  end
end
