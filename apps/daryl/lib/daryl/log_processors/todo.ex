defmodule Daryl.LogProcessor.Todo do

  use GenServer
  alias Backend.Activities.Log

  @todo_regex ~r/^todo/iu

  def start_link(id) do
    GenServer.start_link(__MODULE__, %{id => id})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:create_log, log}, state), do: handle(log, state)
  def handle_cast({:update_log, log}, state), do: handle(log, state)

  def handle(log, state) do
    if log.type != "TODO" && match(log), do: Backend.Activities.update_log(log, %{type: "TODO"})
    {:noreply, state}
  end

  def match(%Log{} = log) do
    Regex.match?(@todo_regex, log.text)
  end

end
