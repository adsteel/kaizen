defmodule Kaizen.User do
  use Kaizen.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string

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
