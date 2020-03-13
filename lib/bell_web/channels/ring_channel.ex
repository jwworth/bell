defmodule BellWeb.RingChannel do
  use Phoenix.Channel

  def join("ring:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("increment_ring", _message, socket) do
    broadcast!(socket, "incremented_ring", %{body: "Something"})
    {:noreply, socket}
  end
end
