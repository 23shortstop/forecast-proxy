defmodule Assignment.Weather.ForecastTest do
  use ExUnit.Case
  alias Assignment.Weather.Forecast

  describe "process" do
    test "successful response" do
      map_body = %{"key" => "value"}
      {:ok, string_body} = Jason.encode(map_body)

      Tesla.Mock.mock fn _ -> {200, %{}, string_body} end

      assert {:ok, forecast} = Forecast.currently_and_daily("1", "1")
      assert forecast == map_body
    end

    test "error response" do
      error_msg = "Poorly formatted request"
      map_body = %{"error" => error_msg}
      {:ok, string_body} = Jason.encode(map_body)

      Tesla.Mock.mock fn _ -> {400, %{}, string_body} end

      assert {:error, error_msg} = Forecast.currently_and_daily("1", "1")
    end

    test "no response" do
      Tesla.Mock.mock fn _ -> {:error, :econnrefused} end

      assert {:error, _error_msg} = Forecast.currently_and_daily("1", "1")
    end

    test "malformed response" do
      string_body = "invalid_json::15"
      Tesla.Mock.mock fn _ -> {200, %{}, string_body} end

      assert {:error, _error_msg} = Forecast.currently_and_daily("1", "1")
    end
  end
end
