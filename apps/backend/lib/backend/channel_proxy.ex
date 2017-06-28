defmodule Backend.ChannelProxy do

  def create_log(log) do
    GenServer.cast(pid(), {:create_log, log})
  end

  def update_log(log) do
    GenServer.cast(pid(), {:update_log, log})
  end

  def delete_log(log) do
    GenServer.cast(pid(), {:delete_log, log})
  end

  defp pid(), do: :pg2.get_closest_pid({:web, Backend.Web.ChannelProxy})

end
