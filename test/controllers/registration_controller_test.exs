defmodule Kaizen.RegistrationControllerTest do
  use Kaizen.ConnCase

  alias Kaizen.User
  alias Kaizen.Repo

  @valid_attrs %{email: "some content", password: "some content", password_confirmation: "some content", username: "some content"}
  @invalid_attrs %{"password" => ""}
  @new_page_text "Create an account"

  test "renders form for new resources", %{conn: conn} do
    conn = get(conn, registration_path(conn, :new))

    assert html_response(conn, 200) =~ @new_page_text
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post(conn, registration_path(conn, :create), user: @valid_attrs)

    assert redirected_to(conn) == user_path(conn, :index)
    assert Repo.get_by(User, Map.take(@valid_attrs, [:email]))
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, registration_path(conn, :create), user: @invalid_attrs)

    assert html_response(conn, 200) =~ @new_page_text
  end
end
