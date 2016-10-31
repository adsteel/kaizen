defmodule Kaizen.SessionControllerTest do
  use Kaizen.ConnCase

  @valid_attrs %{"email" => "example@example.com", "password" => "password"}
  @invalid_attrs %{"password" => "", "email" => ""}
  @new_page_text "Login"

  test "renders form for a new session", %{conn: conn} do
    conn = get(conn, session_path(conn, :new))

    assert html_response(conn, 200) =~ @new_page_text
  end

  test "authenticates and redirects when data is valid", %{conn: conn} do
    insert(:user, email: @valid_attrs["email"])
    conn = post(conn, session_path(conn, :create), session: @valid_attrs)

    assert redirected_to(conn) == story_path(conn, :index)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, session_path(conn, :create), session: @invalid_attrs)

    assert html_response(conn, 200) =~ @new_page_text
  end
end
