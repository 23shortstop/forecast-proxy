defmodule Assignment.DarkSky.Client do
  use Tesla

  @type query_params :: [
          exclude: String.t(),
          extend: String.t(),
          lang: String.t(),
          units: String.t()
        ]
  @type result :: Tesla.Env.result()

  @key Application.fetch_env!(:assignment, :dark_sky_key)
  @base_url Application.fetch_env!(:assignment, :dark_sky_url)

  plug Tesla.Middleware.BaseUrl, @base_url <> "/" <> @key <> "/"
  plug Tesla.Middleware.DecodeJson

  @spec forecast(%Decimal{}, %Decimal{}, query_params) :: result
  def forecast(latitude, longitude, query_params \\ []) do
    get("#{latitude},#{longitude}", query: query_params)
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
