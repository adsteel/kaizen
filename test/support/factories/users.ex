defmodule Kaizen.Factory do

  use ExMachina.Ecto, repo: Kaizen.Repo

  alias Kaizen.User
  alias Comeonin.Bcrypt

  def user_factory do
    %User{
      username: sequence(:username, &"Example username#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: Bcrypt.hashpwsalt("password")
    }
  end
end
