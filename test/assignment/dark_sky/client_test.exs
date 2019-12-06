defmodule Assignment.DarkSky.ClientTest do
  use ExUnit.Case
  alias Assignment.DarkSky.Client

  @test_base_url Application.fetch_env!(:assignment, :dark_sky_url)
  @test_key Application.fetch_env!(:assignment, :dark_sky_key)

  setup do
    Tesla.Mock.mock(fn env -> env end)

    :ok
  end

  describe "forecast" do
    test "sends correct request" do
      latitude = "52.3667"
      longitude = "4.8945"
      query = [exclude: "[hourly]"]

      assert {:ok, env} = Client.forecast(latitude, longitude, query)

      assert env.url == @test_base_url <> "/" <> @test_key <> "/" <> latitude <> "," <> longitude
      assert env.method == :get
      assert env.query == query
    end
  end
end
