defmodule Kaizen.Repo.Migrations.CreateUsersProjectsJoin do
  use Ecto.Migration

  def change do
    create table(:users_projects) do
      add :user_id, :integer
      add :project_id, :integer

      timestamps()
    end

    create index(:users_projects, [:user_id, :project_id], unique: true)
  end
end
