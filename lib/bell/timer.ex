defmodule Bell.Timer do
  use GenServer

  require Ecto.Query

  @heartbeat 1000

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    timer = Process.send_after(self(), :work, @heartbeat)
    {:ok, %{timer: timer}}
  end

  def handle_info(:work, _state) do
    :ok =
      BellWeb.Endpoint.broadcast("ring:lobby", "ring_counts", %{
        active_ring_count: active_ring_count(),
        total_ring_count: total_ring_count()
      })

    timer = Process.send_after(self(), :work, @heartbeat)
    {:noreply, %{timer: timer}}
  end

  def handle_info(_, state) do
    {:ok, state}
  end

  defp active_ring_count do
    rings =
      Bell.Repo.all(
        Ecto.Query.from(r in Bell.Ring,
          where: r.inserted_at > datetime_add(^NaiveDateTime.utc_now(), -18000, "millisecond")
        )
      )

    length(rings)
  end

  defp total_ring_count do
    Bell.Repo.aggregate(Bell.Ring, :count)
  end
end
