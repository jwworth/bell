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
    BellWeb.Endpoint.broadcast("ring:lobby", "latest_ring_count", %{
      body: ring_count()
    })

    Logger.info("...done")

    timer = Process.send_after(self(), :work, 3000)

    {:noreply, %{timer: timer}}
  end

  def handle_info(_, state) do
    Logger.warn("Something's not right")
    {:ok, state}
  end

  defp ring_count do
    rings =
      Bell.Repo.all(
        Ecto.Query.from(r in Bell.Ring,
          where: r.inserted_at > datetime_add(^NaiveDateTime.utc_now(), -1, "minute")
        )
      )

    length(rings)
  end
end
