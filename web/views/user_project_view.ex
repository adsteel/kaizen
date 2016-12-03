require IEx

defmodule Kaizen.UserProjectView do
  use Kaizen.Web, :view

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
