require IEx

defmodule Kaizen.RegistrationController do
  use Kaizen.Web, :controller

  alias Comeonin.Bcrypt
  alias Kaizen.User

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}))
  end

  def create(conn, %{"user" => user_params}) do
    encrypted_params = Map.merge(user_params, %{"password" => Bcrypt.hashpwsalt(user_params["password"])})
    changeset = User.changeset(%User{}, encrypted_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Welcome new user.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
