defmodule TodoQFrontend.LogProcessorProducer do

  use GenStage

  alias TodoQFrontend.Repo
  alias TodoQFrontend.Log

  import Ecto.Query

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    logs = Repo.all(from u in Log, where: u.type == "UNPROCESSED")
    {:producer, %{demand: 0, logs: logs}}
  end

  def handle_demand(demand, state) when demand > 0 do
    state = %{state | demand: state.demand+demand}
    do_handle_demand(state)
  end

  def handle_cast({:process_log, log}, state) do
    state = %{state | logs: [log | state.logs]}
    do_handle_demand(state)
  end

  # private

  defp do_handle_demand(state) do
    {events, logs} = Enum.split(state.logs, state.demand)
    state = %{state | demand: Enum.max([0, state.demand - length(events)]), logs: logs}
    {:noreply, events, state}
  end

  # client functions

  def process_log(log) do
    GenStage.cast(__MODULE__, {:process_log, log})
  end

end
