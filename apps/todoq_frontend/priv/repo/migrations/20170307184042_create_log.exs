defmodule TodoQFrontend.Repo.Migrations.CreateLog do
  use Ecto.Migration

  def change do
    create table(:logs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :text
      add :type, :string
      add :content, :map
      add :activity_id, references(:activities, on_delete: :delete_all, type: :uuid)

      timestamps()
    end

  end
end
