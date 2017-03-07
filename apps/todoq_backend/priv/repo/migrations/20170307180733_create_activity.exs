defmodule TodoQ.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :type, :string, null: false
      add :avgDuration, :integer
      add :lastDone, :utc_datetime
      add :priority, :integer, null: false

      timestamps()
    end

  end
end
