defmodule Kaizen.UserControllerTest do
  use Kaizen.ConnCase

  alias Kaizen.User

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end
end
