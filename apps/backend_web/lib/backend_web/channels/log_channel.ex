defmodule Backend.Web.LogChannel do
  use Backend.Web, :channel
  alias Backend.Web.LogView

  intercept ["insert:log"]

  def join("logs:" <> _activity_id, _payload, socket) do
    {:ok, socket}
  end

  def handle_out("insert:log", payload, socket) do
    push socket, "insert:log", payload
    {:noreply, socket}
  end

  def insert_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      Backend.Web.Endpoint.broadcast!("logs:#{model.activity_id}", "insert:log", payload)
    end
  end

  def update_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      Backend.Web.Endpoint.broadcast!("logs:#{model.activity_id}", "update:log", payload)
    end
  end

  def delete_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      Backend.Web.Endpoint.broadcast!("logs:#{model.activity_id}", "delete:log", payload)
    end
  end

end
