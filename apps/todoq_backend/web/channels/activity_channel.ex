defmodule TodoQ.ActivityChannel do
  use TodoQ.Web, :channel
  alias TodoQ.ActivityView

  def join("activity:" <> _activity_id, _payload, socket) do
    {:ok, socket}
  end

	def insert_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQ.Endpoint.broadcast!("activity:#{model.activity_id}", "insert:activity", payload)
    end
	end

	def update_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQ.Endpoint.broadcast!("activity:#{model.activity_id}", "update:activity", payload)
    end
	end

	def delete_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQ.Endpoint.broadcast!("activity:#{model.activity_id}", "delete:activity", payload)
    end
	end

end
