defmodule Kaizen.User do
  use Kaizen.Web, :model

  alias Comeonin.Bcrypt
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
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
