defmodule Kaizen.StoryControllerTest do
  use Kaizen.ConnCase

  alias Kaizen.Story

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

  @valid_attrs %{creator_id: 42, description: "some content", points: 42, status: "some content", type: "some content"}
  @invalid_attrs %{points: nil}

  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, story_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing stories"
  end

  @tag :login
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, story_path(conn, :new)
    assert html_response(conn, 200) =~ "New story"
  end

  @tag :login
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, story_path(conn, :create), story: @valid_attrs
    assert redirected_to(conn) == story_path(conn, :index)
    assert Repo.get_by(Story, @valid_attrs)
  end

  @tag :login
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, story_path(conn, :create), story: @invalid_attrs
    assert html_response(conn, 200) =~ "New story"
  end

  @tag :login
  test "shows chosen resource", %{conn: conn} do
    story = insert(:story)
    conn = get(conn, story_path(conn, :show, story))
    assert html_response(conn, 200) =~ "Show story"
  end

  @tag :login
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, story_path(conn, :show, -1)
    end
  end

  @tag :login
  test "renders form for editing chosen resource", %{conn: conn} do
    story = insert(:story)
    conn = get conn, story_path(conn, :edit, story)
    assert html_response(conn, 200) =~ "Edit story"
  end

  @tag :login
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    story = insert(:story)
    conn = put conn, story_path(conn, :update, story), story: @valid_attrs
    assert redirected_to(conn) == story_path(conn, :show, story)
    assert Repo.get_by(Story, @valid_attrs)
  end

  @tag :login
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    story = insert(:story)
    conn = put conn, story_path(conn, :update, story), story: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit story"
  end

  @tag :login
  test "deletes chosen resource", %{conn: conn} do
    story = insert(:story)
    conn = delete conn, story_path(conn, :delete, story)
    assert redirected_to(conn) == story_path(conn, :index)
    refute Repo.get(Story, story.id)
  end
end
