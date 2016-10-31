defmodule Kaizen.ProjectControllerTest do
  use Kaizen.ConnCase

  alias Kaizen.Project

  setup %{conn: conn} = config do
    cond do
      config[:login] ->
        user = insert(:user)
        signed_conn = Guardian.Plug.api_sign_in(conn, user)
        {:ok, conn: signed_conn}
      true ->
        :ok
    end
  end

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, project_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing projects"
  end

  @tag :login
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, project_path(conn, :new)
    assert html_response(conn, 200) =~ "New project"
  end

  @tag :login
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @valid_attrs
    assert redirected_to(conn) == project_path(conn, :index)
    assert Repo.get_by(Project, @valid_attrs)
  end

  @tag :login
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @invalid_attrs
    assert html_response(conn, 200) =~ "New project"
  end

  @tag :login
  test "shows chosen resource", %{conn: conn} do
    project = insert(:project)
    conn = get conn, project_path(conn, :show, project)
    assert html_response(conn, 200) =~ project.name
  end

  @tag :login
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, project_path(conn, :show, -1)
    end
  end

  @tag :login
  test "renders form for editing chosen resource", %{conn: conn} do
    project = insert(:project)
    conn = get conn, project_path(conn, :edit, project)
    assert html_response(conn, 200) =~ "Edit project"
  end

  @tag :login
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = put conn, project_path(conn, :update, project), project: @valid_attrs
    assert redirected_to(conn) == project_path(conn, :index)
    assert Repo.get_by(Project, @valid_attrs)
  end

  @tag :login
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = put conn, project_path(conn, :update, project), project: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit project"
  end

  @tag :login
  test "deletes chosen resource", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = delete conn, project_path(conn, :delete, project)
    assert redirected_to(conn) == project_path(conn, :index)
    refute Repo.get(Project, project.id)
  end
end
