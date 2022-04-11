defmodule BandOfTheWeekWeb.PageControllerTest do
  use BandOfTheWeekWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Band Of The Week"
  end
end
