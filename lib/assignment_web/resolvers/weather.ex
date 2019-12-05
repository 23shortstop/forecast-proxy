defmodule AssignmentWeb.Resolvers.Weather do

  def forecast(_parent, %{input: %{latitude: latitude, longitude: longitude}}, _resolution) do
    #TODO: implement resolver
    {:error, :not_implemented}
  end
end
