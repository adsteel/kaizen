defmodule Kaizen.Story do
  use Kaizen.Web, :model

  alias Kaizen.{ Project, User }

  schema "stories" do
    field :type, :string
    field :points, :integer
    field :status, :string
    field :description, :string

    belongs_to :creator, User
    belongs_to :project, Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :points, :status, :creator_id, :description])
    |> validate_required([:type, :points, :status, :creator_id, :project_id])
  end
end
