defmodule Kaizen.Story do
  use Kaizen.Web, :model

  schema "stories" do
    field :type, :string
    field :points, :integer
    field :status, :string
    field :creator_id, :integer
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :points, :status, :creator_id, :description])
    |> validate_required([:type, :points, :status, :creator_id])
  end
end
