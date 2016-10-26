defmodule Kaizen.UserController do
  use Kaizen.Web, :controller

  alias Kaizen.User

  def index(conn, _params) do
    users = Repo.all(User)

    render(conn, "index.html", users: users)
  end
end
