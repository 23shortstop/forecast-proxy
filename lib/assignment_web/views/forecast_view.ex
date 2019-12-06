defmodule AssignmentWeb.ForecastView do

  def render("forecast", %{forecast: forecast}) do
    %{ date: render_date(forecast["currently"]["time"]),
       type: forecast["currently"]["precipType"],
       description: forecast["currently"]["summary"],
       temperature: forecast["currently"]["temperature"],
       wind: %{
         speed: forecast["currently"]["windSpeed"],
         bearing: forecast["currently"]["windBearing"]
       },
       precipitation_probability: forecast["currently"]["precipProbability"],
       daily: forecast["daily"]["data"] |> Enum.map(&render_daily/1)
     }
  end

  defp render_daily(daily) do
    %{ date: render_date(daily["time"]),
       type: daily["precipType"],
       description: daily["summary"],
       temperature: %{
         low: daily["temperatureLow"],
         high: daily["temperatureHigh"]
       }
     }
  end

  defp render_date(unix) do
    DateTime.from_unix!(unix)
  end
end
