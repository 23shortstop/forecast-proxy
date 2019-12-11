defmodule AssignmentWeb.Resolvers.Weather do
  alias Assignment.CacheServer

  def forecast(%{input: %{latitude: latitude, longitude: longitude}}, _) do
    CacheServer.get_forecast({latitude, longitude})
  end
end
