defmodule ForecastProxy.DarkSky.Client do
  use Tesla

  @type coordinates :: {Decimal.t(), Decimal.t()}
  @type query_params :: [
          exclude: String.t(),
          extend: String.t(),
          lang: String.t(),
          units: String.t()
        ]
  @type body :: %{required(String.t()) => any}
  @type result :: {:ok, body} | {:error, String.t()}

  @key Application.fetch_env!(:forecast_proxy, :dark_sky_key)
  @base_url Application.fetch_env!(:forecast_proxy, :dark_sky_url)

  plug Tesla.Middleware.BaseUrl, @base_url <> "/" <> @key <> "/"
  plug Tesla.Middleware.DecodeJson

  @spec forecast(coordinates, query_params) :: result
  def forecast({latitude, longitude}, query_params \\ []) do
    get("#{latitude},#{longitude}", query: query_params)
    |> process_response
  end

  defp process_response({:ok, %{body: body, status: 200}}), do: {:ok, body}
  defp process_response({:ok, %{body: %{"error" => error}}}), do: {:error, error}
  defp process_response(_error), do: {:error, "Unable to receive forecast"}
end
