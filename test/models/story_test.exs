defmodule Kaizen.StoryTest do
  use Kaizen.ModelCase

  alias Kaizen.Story

  @valid_attrs %{creator_id: 42, description: "some content", points: 42, status: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Story.changeset(%Story{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Story.changeset(%Story{}, @invalid_attrs)
    refute changeset.valid?
  end
end
