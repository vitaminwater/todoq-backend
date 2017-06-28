defmodule Backend.Web.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Backend.Web.Endpoint, []),
      worker(Backend.Web.ChannelProxy, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Backend.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
