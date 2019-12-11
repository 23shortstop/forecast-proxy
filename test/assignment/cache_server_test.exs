defmodule Assignment.CacheServerTest do
  use AssignmentWeb.ConnCase

  @cooordinates {"1", "1"}
  @caching_time Application.fetch_env!(:assignment, :caching_time)

  describe "server" do
    setup [:dark_sky_success_mock]

    test "caching results", %{mock: body} do
      # Call CacheServer to save result to cache
      assert {:ok, body} == Assignment.CacheServer.get_forecast(@cooordinates)

      # Reset mock
      new_body = %{new_forecast: "value"}
      Tesla.Mock.mock_global(fn _ -> {200, %{}, new_body} end)

      # Old body means that Tesla wasn't called and result was returned from cache
      assert {:ok, body} == Assignment.CacheServer.get_forecast(@cooordinates)

      # Wait to expire cache
      :timer.sleep(@caching_time)

      # New body means that old result was deleted from cache and Tesla was called
      assert {:ok, new_body} == Assignment.CacheServer.get_forecast(@cooordinates)
    end
  end
end
