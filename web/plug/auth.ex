defmodule Kaizen.Plug.Auth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user = Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, user)
  end
end
