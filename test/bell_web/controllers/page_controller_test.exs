defmodule BellWeb.PageControllerTest do
  use BellWeb.ConnCase

  test "GET /", %{conn: conn} do
    response = get(conn, "/")
    html_response = html_response(response, 200)

    assert html_response =~ "The Bell"
    assert html_response =~ "Nobody is ringing the bell."
    assert html_response =~ "Listen, listen. This wonderful sound brings me back to my true self."
    assert html_response =~ "The bell has been rung 0 times."
  end

  test "GET / with a ring", %{conn: conn} do
    Bell.Repo.insert!(%Bell.Ring{})
    response = get(conn, "/")
    html_response = html_response(response, 200)

    assert html_response =~ "The bell has been rung 1 times."
  end
end
