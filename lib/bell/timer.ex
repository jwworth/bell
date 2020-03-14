require Ecto.Query

defmodule Bell.Timer do
  use GenServer
  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    timer = Process.send_after(self(), :work, 3000)
    {:ok, %{timer: timer}}
  end

  def handle_info(:work, _state) do
    BellWeb.Endpoint.broadcast("ring:lobby", "active_ring_count", %{
      body: BellWeb.RingHelpers.active_ring_count()
    })

    timer = Process.send_after(self(), :work, 3000)

    {:noreply, %{timer: timer}}
  end

  def handle_info(_, state) do
    {:ok, state}
  end
end
