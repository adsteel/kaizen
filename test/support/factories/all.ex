defmodule Kaizen.Factory do

  use ExMachina.Ecto, repo: Kaizen.Repo

  alias Kaizen.{ Project, Story, User }
  alias Comeonin.Bcrypt

  def story_factory do
    %Story{
      type: "Feature",
      points: 0,
      status: "In Progress",
      creator_id: 1
    }

  end

  def user_factory do
    %User{
      username: sequence(:username, &"Example username#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: Bcrypt.hashpwsalt("password")
    }
  end

  def project_factory do
    %Project{
      name: sequence(:name, &"Example name#{&1}"),
    }
  end
end
