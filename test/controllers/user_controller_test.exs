defmodule Kaizen.UserControllerTest do
  use Kaizen.ConnCase

  setup %{conn: conn} = config do
    cond do
      config[:login] ->
        user = insert(:user)
        signed_conn = Guardian.Plug.api_sign_in(conn, user)
        {:ok, conn: signed_conn}
      true ->
        :ok
    end
  end

  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get(conn, user_path(conn, :index))

    assert html_response(conn, 200) =~ "Listing users"
  end
end
