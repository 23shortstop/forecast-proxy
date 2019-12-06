defmodule Assignment.Weather.ForecastTest do
  use AssignmentWeb.ConnCase, async: true
  alias Assignment.Weather.Forecast

  describe "successful response" do
    setup [:dark_sky_success_mock]

    test "process", %{mock: body} do
      assert {:ok, forecast} = Forecast.currently_and_daily("1", "1")
      assert forecast == body
    end
  end

  describe "error response" do
    setup [:dark_sky_error_mock]

    test "process", %{mock: body} do
      assert {:error, error_msg} = Forecast.currently_and_daily("1", "1")
      assert error_msg == body["error"]
    end
  end

  describe "no response" do
    setup do
      Tesla.Mock.mock(fn _ -> {:error, :econnrefused} end)
      :ok
    end

    test "process" do
      assert {:error, _error_msg} = Forecast.currently_and_daily("1", "1")
    end
  end
end
