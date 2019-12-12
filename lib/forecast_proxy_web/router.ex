defmodule ForecastProxyWeb.Router do
  use ForecastProxyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ForecastProxyWeb.Schema,
      interface: :playground
  end
end
