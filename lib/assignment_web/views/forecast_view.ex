defmodule AssignmentWeb.ForecastView do
  use AssignmentWeb, :view

  def render("forecast.json", %{forecast: forecast}) do
    %{ date: render_date(forecast["currently"]["time"]),
       type: forecast["currently"]["precipType"],
       description: forecast["currently"]["summary"],
       temperature: forecast["currently"]["temperature"],
       wind: %{
         speed: forecast["currently"]["windSpeed"],
         bearing: forecast["currently"]["windBearing"]
       },
       precipitation_probability: forecast["currently"]["precipProbability"],
       daily: render_many(forecast["daily"]["data"], AssignmentWeb.DailyView, "daily.json")
     }
  end
end
