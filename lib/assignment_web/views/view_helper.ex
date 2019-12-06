defmodule AssignmentWeb.ViewHelper do
  def render_date(unix) do
    DateTime.from_unix!(unix)
  end
end
