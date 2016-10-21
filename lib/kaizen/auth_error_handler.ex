defmodule Kaizen.AuthErrorHandler do
  import Phoenix.Controller

  def unauthenticated(conn, params) do
    conn
      |> put_flash(:error, "Please sign in")
      |> redirect(to: "/login")
  end
end
