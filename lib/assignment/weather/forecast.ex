defmodule Assignment.Weather.Forecast do
  alias Assignment.DarkSky

  @type body :: %{required(String.t()) => any()}
  @type result :: {:ok, body} | {:error, String.t()}

  @currently_and_daily_query [exclude: "[minutely,hourly,alerts,flags]"]

  @spec currently_and_daily(%Decimal{}, %Decimal{}) :: result
  def currently_and_daily(latitude, longitude) do
    DarkSky.Client.forecast(latitude, longitude, @currently_and_daily_query)
    |> process_response
  end

  defp process_response({:ok, %{body: body, status: 200}}) do
    {:ok, body}
  end

  defp process_response({:ok, %{body: %{"error" => error}}}) do
    {:error, error}
  end

  defp process_response(_error) do
    {:error, "Unable to receive forecast"}
  end
end
