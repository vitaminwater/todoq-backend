defmodule TodoQFrontend.LogProcessorProducer do

  use GenStage

  alias TodoQFrontend.Repo
  alias TodoQFrontend.Log

  import Ecto.Query

  def start_link() do
    IO.puts("TodoQFrontend.LogProcessorProducer.start_link")
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    IO.puts("TodoQFrontend.LogProcessorProducer.init")
    logs = Repo.all(from u in Log, where: u.type == "UNPROCESSED")
    IO.inspect logs
    {:producer, logs}
  end

  def handle_demand(demand, logs) when demand > 0 do
    IO.puts("TodoQFrontend.LogProcessorProducer.handle_demand")
    IO.inspect(demand)
    {ret, rest} = Enum.split(logs, demand)
    {:noreply, ret, rest}
  end

  def handle_cast({:process_log, log}, logs) do
    IO.inspect("TodoQFrontend.LogProcessorProducer.handle_cast :process_log")
    IO.inspect(log)
    IO.inspect(logs)
    {:noreply, [log | logs]}
  end

  # client functions

  def process_log(log) do
    IO.inspect("TodoQFrontend.LogProcessorProducer.process_log")
    GenStage.cast(__MODULE__, {:process_log, log})
  end

end
