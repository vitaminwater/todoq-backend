defmodule Backend.Repo.Migrations.CreateBackend.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:email])
  end
end
