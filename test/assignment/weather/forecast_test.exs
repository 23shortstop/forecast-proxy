defmodule Assignment.Weather.ForecastTest do
  use AssignmentWeb.ConnCase, async: true
  alias Assignment.Weather.Forecast

  @coordinates {"1", "1"}

  describe "successful response" do
    setup [:dark_sky_success_mock]

    test "process", %{mock: body} do
      assert {:ok, forecast} = Forecast.currently_and_daily(@coordinates)
      assert forecast == body
    end
  end

  describe "error response" do
    setup [:dark_sky_error_mock]

    test "process", %{mock: body} do
      assert {:error, error_msg} = Forecast.currently_and_daily(@coordinates)
      assert error_msg == body["error"]
    end
  end

  describe "no response" do
    setup do
      Tesla.Mock.mock(fn _ -> {:error, :econnrefused} end)
      :ok
    end

    test "process" do
      assert {:error, _error_msg} = Forecast.currently_and_daily(@coordinates)
    end
  end
end
