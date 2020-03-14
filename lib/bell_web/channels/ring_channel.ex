require Ecto.Query

defmodule BellWeb.RingChannel do
  use Phoenix.Channel

  def join("ring:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("increment_ring", _message, socket) do
    increment_bell()

    broadcast!(socket, "incremented_ring", %{
      body: "#{ring_count()} people are ringing the bell now"
    })

    {:noreply, socket}
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

  defp increment_bell() do
    Bell.Repo.insert(%Bell.Ring{})
  end
end
