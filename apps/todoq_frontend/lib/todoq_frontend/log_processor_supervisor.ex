defmodule TodoQFrontend.LogProcessorSupervisor do

  use ConsumerSupervisor

  def start_link() do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(TodoQFrontend.LogProcessor, [], restart: :temporary)
    ]
    {:ok, children, strategy: :one_for_one, subscribe_to: [{TodoQFrontend.LogProcessorProducer, max_demand: 10}]}
  end

end
