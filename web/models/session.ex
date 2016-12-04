defmodule Kaizen.Session do
  use Kaizen.Web, :model

  alias Comeonin.Bcrypt
  alias Kaizen.{ Session, Repo, User }

  schema "sessions" do
    field :email, :string
    field :password, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end

  def find_and_confirm_password(params \\ %{}) do
    user = Repo.get_by(User, email: params["email"])

    case valid_credentials?(params["password"], user) do
      true -> {:ok, user}
      false -> {:error, Session.changeset(%Session{}, params)}
    end
  end

  defp valid_credentials?(_password, user) when is_nil(user), do: false
  defp valid_credentials?(password, user) do
    Bcrypt.checkpw(password, user.password)
  end
end
