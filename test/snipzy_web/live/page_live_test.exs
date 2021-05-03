defmodule SnipzyWeb.PageLiveTest do
  use SnipzyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/editor")
    assert disconnected_html =~ "Your safe space for snippets"
    assert render(page_live) =~ "Your safe space for snippets"
  end
end
