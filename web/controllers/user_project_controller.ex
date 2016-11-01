defmodule Kaizen.UserProjectController do
  use Kaizen.Web, :controller

  alias Kaizen.{ Project, ProjectView, UserProject, User }

  def create(conn, %{"user_project" => user_project_params, "project_id" => project_id}) do
    up_params = Map.put(user_project_params, "project_id", project_id)
    changeset = UserProject.changeset(%UserProject{}, up_params)
    project = Repo.get!(Project, project_id) |> Repo.preload(:users)
    users = Repo.all(
      from(u in User,
        left_join: up in assoc(u, :user_projects),
        where: up.project_id != ^project.id or is_nil(up.project_id),
        select: {u.username, u.id})
    )
    user_projects = Repo.all(
      from up in UserProject,
        where: up.project_id == ^project.id,
        select: up
    ) |> Repo.preload(:user)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User successfully added to project.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, changeset} ->
        render(conn, ProjectView, "show.html", changeset: changeset, project: project, users: users, user_projects: user_projects)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_project = Repo.get!(UserProject, id) |> Repo.preload(:project)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_project)

    conn
    |> put_flash(:info, "Project user deleted successfully.")
    |> redirect(to: project_path(conn, :show, user_project.project))
  end
end
