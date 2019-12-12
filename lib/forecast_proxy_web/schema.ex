defmodule ForecastProxyWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(ForecastProxyWeb.Schema.WeatherTypes)

  alias ForecastProxyWeb.Resolvers

  query do
    @desc "Get weather forecast"
    field :weather_forecast, :forecast do
      arg(:input, non_null(:coordinate_input))
      resolve(&Resolvers.Weather.forecast/2)
    end
  end
end
