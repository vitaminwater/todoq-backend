defmodule Daryl.LogProcessor.Note do

  use GenServer
  alias Backend.Activities.Log

  def start_link(id) do
    GenServer.start_link(__MODULE__, %{id => id})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:create_log, log}, state), do: handle(log, state)
  def handle_cast({:update_log, log}, state), do: handle(log, state)

  def handle(log, state) do
    if log.type != "NOTE" && match(log), do: Backend.Activities.update_log(log, %{type: "NOTE"})
    {:noreply, state}
  end

  # TODO find something better
  def match(%Log{} = log) do
    !Daryl.LogProcessor.Link.match(log) && !Daryl.LogProcessor.Todo.match(log)
  end

end
