defmodule TodoQ.LogChannel do
  use TodoQ.Web, :channel
  alias TodoQ.LogView

  def join("logs:" <> _activity_id, _payload, socket) do
    {:ok, socket}
  end

	def insert_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      TodoQ.Endpoint.broadcast!("logs:#{model.activity_id}", "insert:log", payload)
    end
	end

	def update_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      TodoQ.Endpoint.broadcast!("logs:#{model.activity_id}", "update:log", payload)
    end
	end

	def delete_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      TodoQ.Endpoint.broadcast!("logs:#{model.activity_id}", "delete:log", payload)
    end
	end

end
