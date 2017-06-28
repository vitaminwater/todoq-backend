defmodule Backend.Web.ChannelProxy do
  require Logger

  use GenServer

  @group_name {:web, __MODULE__}

  def start_link() do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(state) do
    :pg2.create(@group_name)
    :pg2.join(@group_name, self())
    {:ok, state}
  end

  @doc """
    
    Log functions

  """

  def handle_cast({:create_log, log}, state) do
    Backend.Web.LogChannel.create_log(log)
    {:noreply, state}
  end

  def handle_cast({:update_log, log}, state) do
    Backend.Web.LogChannel.update_log(log)
    {:noreply, state}
  end

  def handle_cast({:delete_log, log}, state) do
    Backend.Web.LogChannel.delete_log(log)
    {:noreply, state}
  end

end
