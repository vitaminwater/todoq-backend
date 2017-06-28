defmodule Daryl.Node.Supervisor do
  require Logger

  use Supervisor

  def start_link() do
    Logger.info("Daryl.Node.Supervisor.start_link")
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    Logger.info("Daryl.Node.Supervisor.init")
    children = [
      supervisor(Daryl.Supervisor, [123]),
    ]

    supervise(children, strategy: :one_for_one)
  end

end
