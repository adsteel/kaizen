defmodule Kaizen.Project do
  use Kaizen.Web, :model

  alias Kaizen.{ UserProject, User, Story }

  schema "projects" do
    field :name, :string
    field :description, :string

    has_many :user_projects, UserProject
    has_many :stories, Story
    has_many :creators, through: [:stories, :creator]
    many_to_many :users, User, join_through: "users_projects"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name])
  end
end
