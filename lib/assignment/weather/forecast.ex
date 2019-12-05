defmodule Assignment.Weather.Forecast do
  alias Assignment.DarkSky

  @currently_and_daily_query [exclude: "[minutely,hourly,alerts,flags]"]
  @error_msg "Unable to receive forecast"

  def currently_and_daily(latitude, longitude) do
    DarkSky.Client.forecast(latitude, longitude, @currently_and_daily_query)
    |> process_response
  end

  defp process_response({:ok, %{body: body, status: 200}}) do
    decode(body)
  end

  defp process_response({:ok, %{body: error_body}}) do
    with {:ok, %{"error" => error}} <- decode(error_body) do
      {:error, error}
    end
  end

  defp process_response({:error, _}) do
    {:error, @error_msg}
  end

  defp decode(json_string) do
    case Jason.decode(json_string) do
      {:ok, parsed} -> {:ok, parsed}
      _ -> {:error, @error_msg}
    end
  end
end
