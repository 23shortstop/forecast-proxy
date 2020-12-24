defmodule ForecastProxyWeb.Resolvers.WeatherTest do
  use ForecastProxyWeb.ConnCase, async: false

  @input %{latitude: "52.3667", longitude: "4.8945"}
  @error_input %{latitude: "99999999", longitude: "99999999"}
  @query """
    query WeatherForecast($input: CoordinateInput!) {
      weatherForecast(input: $input) {
        date
        type
        description
        temperature
        wind {
          speed
          bearing
        }
        precipitationProbability
        daily {
          date
          type
          description
          temperature {
            low
            high
          }
        }
      }
    }
  """

  describe "success forecast" do
    setup [:dark_sky_success_mock]

    test "request", %{mock: mock_body} do
      res =
        build_conn()
        |> post("/graphiql", %{query: @query, variables: %{input: @input}})
        |> json_response(200)

      assert %{"data" => %{"weatherForecast" => forecast}} = res
      assert forecast["temperature"] == mock_body["currently"]["temperature"]

      assert forecast["date"] ==
               mock_body["currently"]["time"]
               |> DateTime.from_unix!()
               |> Date.to_iso8601()

      assert forecast["description"] == mock_body["currently"]["summary"]
      assert forecast["precipitationProbability"] == mock_body["currently"]["precipProbability"]
      assert forecast["type"] == mock_body["currently"]["precipType"]
      assert forecast["wind"]["bearing"] == mock_body["currently"]["windBearing"]
      assert forecast["wind"]["speed"] == mock_body["currently"]["windSpeed"]

      Enum.zip(forecast["daily"], mock_body["daily"]["data"])
      |> Enum.each(fn {daily_res, daily_mock} ->
        assert daily_res["date"] ==
                 daily_mock["time"]
                 |> DateTime.from_unix!()
                 |> Date.to_iso8601()

        assert daily_res["description"] == daily_mock["summary"]
        assert daily_res["type"] == daily_mock["precipType"]
        assert daily_res["temperature"]["high"] == daily_mock["temperatureHigh"]
        assert daily_res["temperature"]["low"] == daily_mock["temperatureLow"]
      end)
    end
  end

  describe "error forecast" do
    setup [:dark_sky_error_mock]

    test "request", %{mock: mock_body} do
      res =
        build_conn()
        |> post("/graphiql", %{query: @query, variables: %{input: @error_input}})
        |> json_response(200)

      assert %{"errors" => [error]} = res
      assert error["message"] == mock_body["error"]
    end
  end
end
