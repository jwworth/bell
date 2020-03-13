defmodule BellWeb.PageController do
  use BellWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
