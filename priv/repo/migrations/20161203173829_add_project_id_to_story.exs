defmodule Kaizen.Repo.Migrations.AddProjectIdToStory do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :project_id, :integer, null: false
    end
  end
end
