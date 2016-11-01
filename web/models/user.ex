defmodule Kaizen.User do
  use Kaizen.Web, :model

  alias Kaizen.{ Project, UserProject }

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string

    has_many :user_projects, UserProject
    many_to_many :projects, Project, join_through: "users_projects"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
