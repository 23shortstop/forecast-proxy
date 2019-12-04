defmodule Assignment.DarkSky.Client do
  use Tesla

  @key Application.fetch_env!(:assignment, :dark_sky_key)

  plug Tesla.Middleware.BaseUrl, "https://api.darksky.net/forecast/#{@key}/"

  def forecast(latitude, longitude) do
    get(latitude <> "," <> longitude)
  end
end
