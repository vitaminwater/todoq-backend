defmodule Backend.Repo.Migrations.CreateBackend.Activities.Log do
  use Ecto.Migration

  def change do
    create table(:activities_logs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :type, :text
      add :content, :map
      add :activity_id, references(:activities_activities, on_delete: :delete_all, type: :uuid)

      timestamps()
    end

  end
end
