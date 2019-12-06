defmodule AssignmentWeb.DailyView do
  use AssignmentWeb, :view

  def render("daily.json", %{daily: daily}) do
    %{
      date: render_date(daily["time"]),
      type: daily["precipType"],
      description: daily["summary"],
      temperature: %{
        low: daily["temperatureLow"],
        high: daily["temperatureHigh"]
      }
    }
  end
end
