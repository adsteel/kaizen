defmodule Kaizen.RegistrationController do
  use Kaizen.Web, :controller

  alias Comeonin.Bcrypt
  alias Kaizen.User

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.registration_changeset(%User{}))
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully registered #{user.username}.")
        |> redirect(to: project_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
