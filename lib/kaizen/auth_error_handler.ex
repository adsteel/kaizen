defmodule Kaizen.AuthErrorHandler do
  import Phoenix.Controller

  def unauthenticated(conn, _params) do
    conn
      |> put_flash(:error, "Please sign in")
      |> redirect(to: "/login")
  end
end
