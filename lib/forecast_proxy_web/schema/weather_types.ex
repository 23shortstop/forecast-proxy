defmodule ForecastProxyWeb.Schema.WeatherTypes do
  use Absinthe.Schema.Notation

  object :forecast do
    field :date, :date, resolve: fetch(["currently", "time"], &DateTime.from_unix!/1)
    field :type, :string, resolve: fetch(["currently", "precipType"])
    field :description, :string, resolve: fetch(["currently", "summary"])
    field :temperature, :float, resolve: fetch(["currently", "temperature"])
    field :wind, :wind, resolve: parent()
    field :precipitation_probability, :float, resolve: fetch(["currently", "precipProbability"])
    field :daily, list_of(:daily), resolve: fetch(["daily", "data"])
  end

  object :wind do
    field :speed, :float, resolve: fetch(["currently", "windSpeed"])
    field :bearing, :integer, resolve: fetch(["currently", "windBearing"])
  end

  object :daily do
    field :date, :date, resolve: fetch(["time"], &DateTime.from_unix!/1)
    field :type, :string, resolve: fetch(["precipType"])
    field :description, :string, resolve: fetch(["summary"])
    field :temperature, :temperature, resolve: parent()
  end

  object :temperature do
    field :low, :float, resolve: fetch(["temperatureLow"])
    field :high, :float, resolve: fetch(["temperatureHigh"])
  end

  input_object :coordinate_input do
    field :latitude, non_null(:decimal)
    field :longitude, non_null(:decimal)
  end

  defp fetch(path, modify) do
    fn data, _, _ -> {:ok, modify.(get_in(data, path))} end
  end

  defp fetch(path) do
    fn data, _, _ -> {:ok, get_in(data, path)} end
  end

  defp parent() do
    fn data, _, _ -> {:ok, data} end
  end
end
