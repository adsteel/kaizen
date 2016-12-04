defmodule Kaizen.Plug.AuthTest do
  use Kaizen.ConnCase

  test "current user is added to assigns" do
    user = insert(:user)
    conn = conn() |> Guardian.Plug.api_sign_in(user) |> Kaizen.Plug.Auth.call(%{})

    assert Map.get(conn.assigns, :current_user) == user
  end
end
