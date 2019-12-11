defmodule Assignment.CacheServer do
  use GenServer

  alias Assignment.Weather.Forecast

  # one hour
  @caching_time 60 * 60 * 1000

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_forecast(coordinates) do
    GenServer.call(__MODULE__, {:get, coordinates})
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:get, coordinates}, _from, cache) do
    case Map.fetch(cache, coordinates) do
      {:ok, cached_forecast} ->
        {:reply, cached_forecast, cache}

      _ ->
        result = Forecast.currently_and_daily(coordinates)
        new_state = Map.put(cache, coordinates, result)
        Process.send_after(self(), {:drop, coordinates}, @caching_time)
        {:reply, result, new_state}
    end
  end

  def handle_info({:drop, coordinates}, cache) do
    new_cache = Map.delete(cache, coordinates)
    {:noreply, new_cache}
  end
end
