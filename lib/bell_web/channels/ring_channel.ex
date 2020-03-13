defmodule BellWeb.RingChannel do
  use Phoenix.Channel

  def join("ring:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("increment_ring", _message, socket) do
    increment_bell()

    broadcast!(socket, "incremented_ring", %{
      body: "#{bell_count()} people are ringing the bell now"
    })

    {:noreply, socket}
  end

  defp bell_count do
    Bell.Repo.aggregate(Bell.Ring, :count)
  end

  defp increment_bell() do
    Bell.Repo.insert(%Bell.Ring{})
  end
end
