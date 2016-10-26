defmodule Kaizen.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :type, :string, null: false
      add :points, :integer, null: false
      add :status, :string, null: false
      add :creator_id, :integer, null: false
      add :description, :text

      timestamps()
    end

  end
end
