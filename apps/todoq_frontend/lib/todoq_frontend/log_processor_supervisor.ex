defmodule TodoQFrontend.LogProcessorSupervisor do

  use ConsumerSupervisor

  def start_link() do
    IO.puts("TodoQFrontend.LogProcessorSupervisor.start_link")
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    IO.puts("TodoQFrontend.LogProcessorSupervisor.init")
    children = [
      worker(TodoQFrontend.LogProcessor, [], restart: :temporary)
    ]
    {:ok, children, strategy: :simple_one_for_one, subscribe_to: [{TodoQFrontend.LogProcessorProducer, max_demand: 10}]}
  end

end
