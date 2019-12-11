defmodule Assignment.DarkSky.TestHelper do
  def dark_sky_success_mock(_) do
    mock_body =
      File.read!("test/support/dark_sky/fixtures/success_body.json")
      |> Jason.decode!()

    Tesla.Mock.mock_global(fn _ -> {200, %{}, mock_body} end)
    {:ok, mock: mock_body}
  end

  def dark_sky_error_mock(_) do
    mock_body =
      File.read!("test/support/dark_sky/fixtures/error_body.json")
      |> Jason.decode!()

    Tesla.Mock.mock_global(fn _ -> {400, %{}, mock_body} end)
    {:ok, mock: mock_body}
  end
end
