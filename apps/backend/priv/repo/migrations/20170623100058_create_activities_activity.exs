defmodule Backend.Repo.Migrations.CreateBackend.Activities.Activity do
  use Ecto.Migration

  def change do
    create table(:activities_activities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :why, :string, null: false
      add :image, :string, null: false
      add :color, :string, null: false
      add :avgDuration, :integer, null: false
      add :skippable, :boolean, default: true, null: false

      add :invest, :integer, null: false

      add :type, :string
      add :deadline, :utc_datetime
      add :frequency, :string

      add :lastDone, :utc_datetime

      add :randomPath, :string

      timestamps()
    end

  end
end
