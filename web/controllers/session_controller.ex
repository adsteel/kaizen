defmodule Kaizen.SessionController do
  use Kaizen.Web, :controller

  alias Kaizen.Session

  def new(conn, _params) do
    changeset = Session.changeset(%Session{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"session" => session_params}) do
    case Session.find_and_confirm_password(session_params) do
      {:ok, user} ->
         conn
         |> Guardian.Plug.sign_in(user)
         |> put_flash(:info, "Welcome, #{user.username}")
         |> redirect(to: project_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Invalid credentials.")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: session_path(conn, :new))
  end
end
