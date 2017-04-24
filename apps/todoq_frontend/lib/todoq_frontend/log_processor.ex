defmodule TodoQFrontend.LogProcessor do
  @moduledoc """
  Processes link logs
  """

  alias TodoQFrontend.Repo
  alias TodoQFrontend.BroadcastRepo
  alias TodoQFrontend.Log

  import Ecto.Query


  def start_link(log) do
    IO.puts("TodoQFrontend.LogProcessor.start_link")
    Task.start_link(fn -> handle_link_log(log) end)
  end

  def handle_link_log(log) do
    IO.puts("TodoQFrontend.LogProcessor.handle_link")
    IO.inspect(log)
    changeset = log
                |> Log.changeset(%{type: "NOTE"})
    BroadcastRepo.update!(changeset)
  end

end
