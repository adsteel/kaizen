defmodule Kaizen.Project.StoryView do
  use Kaizen.Web, :view

  def render("index.json", %{stories: stories}) do
    %{
        data: Enum.map(stories, &story_json/1)
      }
  end

  defp story_json(story) do
    %{
      creator: story.creator.username,
      description: story.description,
      id: Integer.to_string(story.id),
      status: story.status,
      story_type: story.type
    }
  end
end
