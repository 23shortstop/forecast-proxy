defmodule AssignmentWeb.Schema.WeatherTypes do
  use Absinthe.Schema.Notation

  object :forecast do
    field :date, :date
    field :type, :string
    field :description, :string
    field :temperature, :float
    field :wind, :wind
    field :precipitation_probability, :float
    field :daily, list_of(:daily)
  end

  object :wind do
    field :speed, :float
    field :bearing, :integer
  end

  object :daily do
    field :date, :date
    field :type, :string
    field :description, :string
    field :temperature, :temperature
  end

  object :temperature do
    field :low, :float
    field :high, :float
  end

  input_object :coordinate_input do
    field :latitude, non_null(:decimal)
    field :longitude, non_null(:decimal)
  end
end
