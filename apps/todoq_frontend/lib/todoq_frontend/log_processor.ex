defmodule TodoQFrontend.LogProcessor do
  @moduledoc """
  Processes link logs
  """

  alias TodoQFrontend.BroadcastRepo
  alias TodoQFrontend.Log

  @url_regex ~r"#\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))#iS"

  @type_matchers [
    { @url_regex, :link },
  ]

  def start_link(log) do
    Task.start_link(fn -> handle(log) end)
  end

  defp handle(log, type_matchers \\ @type_matchers)
  defp handle(log, []), do: handle_log(:note, log)
  defp handle(log, type_matchers) do
    [head | tail] = type_matchers
    {regex, type} = head
    if Regex.match?(regex, log.text) do
      handle_log(type, log)
    else
      handle(log, tail)
    end
  end

  defp handle_log(:note, log) do
    changeset = log
                |> Log.changeset(%{type: "NOTE"})
    BroadcastRepo.update!(changeset)
  end

  defp handle_log(:link, log) do
    changeset = log
                |> Log.changeset(%{type: "LINK"})
    BroadcastRepo.update!(changeset)
  end

end
