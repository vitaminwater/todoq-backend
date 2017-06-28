defmodule Daryl.LogProcessor.Link do
  require Logger

  use GenServer
  alias Backend.Activities.Log

  @url_regex ~r"^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)"

  def start_link(id) do
    Logger.info(id)
    GenServer.start_link(__MODULE__, %{id => id})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:create_log, log}, state) do
    if match(log), do: Backend.Activities.update_log(log, %{type: "LINK"})
    {:noreply, state}
  end

  def handle_cast({:update_log, log}, state) do
    cond do
      log.type == "LINK" && !match(log) ->
        # TODO unindex link from elasticsearch
        {:noreply, state}
      log.type != "LINK" && match(log) ->
        Backend.Activities.update_log(log, %{type: "LINK"})
        {:noreply, state}
      true ->
        {:noreply, state}
    end
  end

  def match(%Log{} = log) do
    Regex.match?(@url_regex, log.text)
  end

end
