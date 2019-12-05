defmodule Assignment.Weather.ForecastTest do
  use ExUnit.Case
  alias Assignment.Weather.Forecast

  describe "process" do
    test "successful response" do
      body = File.read!("test/support/fixtures/dark_sky/success_body.json")
             |> Jason.decode!
      Tesla.Mock.mock fn _ -> {200, %{}, body} end

      assert {:ok, forecast} = Forecast.currently_and_daily("1", "1")
      assert forecast == body
    end

    test "error response" do
      body = File.read!("test/support/fixtures/dark_sky/error_body.json")
             |> Jason.decode!
      Tesla.Mock.mock fn _ -> {400, %{}, body} end

      assert {:error, error_msg} = Forecast.currently_and_daily("1", "1")
      assert error_msg == body["error"]
    end

    test "no response" do
      Tesla.Mock.mock fn _ -> {:error, :econnrefused} end

      assert {:error, _error_msg} = Forecast.currently_and_daily("1", "1")
    end
  end
end
