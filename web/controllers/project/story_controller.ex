defmodule Kaizen.Project.StoryController do
  use Kaizen.Web, :controller

  alias Kaizen.{ Project, Story }

  def create(conn, %{"project_id" => project_id, "story" => story_params}) do
    project = Repo.get!(Project, project_id)
    story_changeset = Story.changeset(%Story{status: "unstarted", creator_id: Guardian.Plug.current_resource(conn).id, project_id: project.id}, story_params)

    case Repo.insert(story_changeset) do
      {:ok, _story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, story_changeset} ->
        render(conn, Kaizen.ProjectView, "show.html", project: project, story_changeset: story_changeset)
    end
  end

  def delete(conn, %{"id" => id, "project_id" => project_id}) do
    story = Repo.get!(Story, id)
    project = Repo.get!(Project, project_id)

    Repo.delete!(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: project_path(conn, :show, project))
  end
end
