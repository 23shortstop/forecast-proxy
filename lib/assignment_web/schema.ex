defmodule AssignmentWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types AssignmentWeb.Schema.WeatherTypes

  alias AssignmentWeb.Resolvers

  query do
    @desc "Get a user of the blog"
    field :weather_forecast, :forecast do
      arg :input, non_null(:coordinate_input)
      resolve &Resolvers.Weather.forecast/3
    end
  end
end
