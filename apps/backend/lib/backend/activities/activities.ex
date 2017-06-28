defmodule Backend.Activities do

  import Ecto.Query, warn: false
  alias Backend.Repo

  @doc """

    Activity Functions

  """

  alias Backend.Activities.Activity

  def list_activities, do: Repo.all(Activity)
  def get_activity!(id), do: Repo.get!(Activity, id)
  def create_activity(attrs \\ %{}), do: %Activity{} |> Activity.changeset(attrs) |> Repo.insert()
  def update_activity(%Activity{} = activity, attrs), do: activity |> Activity.changeset(attrs) |> Repo.update()
  def delete_activity(%Activity{} = activity), do: Repo.delete(activity)
  def change_activity(%Activity{} = activity), do: Activity.changeset(activity, %{})

  @doc """

    Log Functions

  """

  alias Backend.Activities.Log

  def list_logs(activity_id), do: Repo.all(from u in Log, where: u.activity_id == ^activity_id, order_by: :inserted_at)
  def get_log!(id), do: Repo.get!(Log, id)

  def create_log(activity_id, attrs \\ %{}) do
    with {:ok, %Log{} = log} = res <- %Log{activity_id: activity_id} |> Log.changeset(attrs) |> Repo.insert() do
      Backend.ChannelProxy.create_log(log)
      res
    end
  end

  def update_log(%Log{} = log, attrs) do
    with {:ok, %Log{} = newLog} = res <- log |> Log.changeset(attrs) |> Repo.update() do
      Backend.ChannelProxy.update_log(newLog)
      res
    end
  end

  def delete_log(%Log{} = log) do
    with {:ok, %Log{}} = res <- Repo.delete(log) do
      Backend.ChannelProxy.delete_log(log)
      res
    end
  end

  def change_log(%Log{} = log), do: Log.changeset(log, %{})

end
