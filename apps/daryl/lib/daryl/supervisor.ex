defmodule Daryl.Supervisor do
  require Logger

  use Supervisor

  def start_link(id) do
    Logger.info("Daryl.Supervisor.start_link")
    Supervisor.start_link(__MODULE__, id)
  end

  def init(id) do
    Logger.info("Daryl.Supervisor.init")
    children = [
      worker(Daryl.LogProcessor.Link, [id]),
      worker(Daryl.LogProcessor.Note, [id]),
      worker(Daryl.LogProcessor.Todo, [id]),
    ]

    supervise(children, strategy: :one_for_one)
  end

end
