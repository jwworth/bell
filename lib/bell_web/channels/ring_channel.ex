defmodule BellWeb.RingChannel do
  use Phoenix.Channel
  require Logger

  def join("ring:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("increment_ring" <> user_id, _message, socket) do
    case Hammer.check_rate("increment_ring:#{user_id}", 15_000, 1) do
      {:allow, _count} ->
        {:ok, _ring} = Bell.Repo.insert(%Bell.Ring{})
        {:noreply, socket}

      {:deny, _limit} ->
        {:noreply, socket}
    end
  end
end
