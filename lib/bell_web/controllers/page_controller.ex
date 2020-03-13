defmodule BellWeb.PageController do
  use BellWeb, :controller

  def index(conn, _params) do
    total_ring_count = Bell.Repo.aggregate(Bell.Ring, :count)
    render(conn, "index.html", total_ring_count: total_ring_count)
  end
end
