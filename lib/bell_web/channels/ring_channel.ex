defmodule BellWeb.RingChannel do
  use Phoenix.Channel
  require Logger

  def join("ring:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("increment_ring", _message, socket) do
    increment_bell()

    broadcast!(socket, "active_ring_count", %{
      body: BellWeb.RingHelpers.active_ring_count()
    })

    {:noreply, socket}
  end

  defp increment_bell() do
    Bell.Repo.insert(%Bell.Ring{})
  end
end
