defmodule ForecastProxyWeb.Resolvers.Weather do
  alias ForecastProxy.CacheServer

  def forecast(%{input: %{latitude: latitude, longitude: longitude}}, _) do
    CacheServer.get_forecast({latitude, longitude})
  end
end
