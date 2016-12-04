defmodule Kaizen.UserView do
  use Kaizen.Web, :view

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
