defmodule TodoQ.ActivityChannel do
  use TodoQ.Web, :channel
  alias TodoQ.LogView

  def join("activity:" <> activity_id, _payload, socket) do
    {:ok, socket}
  end

	def insert_log(model) do
    Task.start fn ->
      payload = LogView.render("log.json", log: model)
      TodoQ.Endpoint.broadcast!("activity:#{model.activity_id}", "insert:log", payload)
    end
	end

end
