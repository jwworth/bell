defmodule BellWeb.ErrorViewTest do
  use BellWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    page = render_to_string(BellWeb.ErrorView, "404.html", [])
    assert page =~ "The Bell"
    assert page =~ "The bell is not found."
  end

  test "renders 500.html" do
    page = render_to_string(BellWeb.ErrorView, "500.html", [])
    assert page =~ "The Bell"
    assert page =~ "The bell is broken."
  end
end
