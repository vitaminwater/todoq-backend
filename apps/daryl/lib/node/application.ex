defmodule Daryl.Node.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Daryl.Node.Supervisor.start_link()
  end
end
