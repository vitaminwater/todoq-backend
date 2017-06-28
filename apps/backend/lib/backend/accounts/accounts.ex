defmodule Backend.Accounts do
  require Logger

  import Ecto.Query, warn: false
  alias Backend.Repo
  import Ecto.Changeset, only: [put_change: 3]

  alias Backend.Accounts.User

  def list_users, do: Repo.all(User)
  
  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> hash_password()
    |> Repo.insert()
  end

  defp hash_password(changeset) do
    Logger.info(changeset.params["password"])
    changeset
    |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.params["password"]))
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user), do: Repo.delete(user)

  def change_user(%User{} = user), do: User.changeset(user, %{})
end
