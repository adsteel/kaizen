defmodule Kaizen.UserProject do
  use Kaizen.Web, :model

  alias Kaizen.{ Project, User }

  schema "users_projects" do
    belongs_to :user, User
    belongs_to :project, Project

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :project_id])
    |> validate_required([:user_id, :project_id])
  end
end
