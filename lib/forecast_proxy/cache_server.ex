defmodule ForecastProxy.CacheServer do
  use GenServer

  alias ForecastProxy.Weather.Forecast

  @caching_time Application.fetch_env!(:forecast_proxy, :caching_time)

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_forecast(coordinates) do
    GenServer.call(__MODULE__, {:get, coordinates})
  end

  def init(initial_cache) do
    {:ok, initial_cache}
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
