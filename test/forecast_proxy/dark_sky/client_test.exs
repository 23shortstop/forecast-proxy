defmodule ForecastProxy.DarkSky.ClientTest do
  use ExUnit.Case
  alias ForecastProxy.DarkSky.Client

  @test_base_url Application.fetch_env!(:forecast_proxy, :dark_sky_url)
  @test_key Application.fetch_env!(:forecast_proxy, :dark_sky_key)
  @latitude "52.3667"
  @longitude "4.8945"
  @query [exclude: "[hourly]"]

  setup do
    url = @test_base_url <> "/" <> @test_key <> "/" <> @latitude <> "," <> @longitude

    Tesla.Mock.mock(fn %{url: ^url, method: :get, query: @query} ->
      %Tesla.Env{status: 200}
    end)

    :ok
  end

  describe "forecast" do
    test "sends correct request" do
      assert {:ok, _} = Client.forecast({@latitude, @longitude}, @query)
    end
  end
end
