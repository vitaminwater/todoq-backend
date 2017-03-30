defmodule TodoQFrontend.ActivityChannel do
  use TodoQFrontend.Web, :channel
  alias TodoQFrontend.ActivityView

  def join("activity:" <> _id, _payload, socket) do
    {:ok, socket}
  end

	def insert_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQFrontend.Endpoint.broadcast!("activity:#{model.id}", "insert:activity", payload)
    end
	end

	def update_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQFrontend.Endpoint.broadcast!("activity:#{model.id}", "update:activity", payload)
    end
	end

	def delete_activity(model) do
    Task.start fn ->
      payload = ActivityView.render("activity.json", activity: model)
      TodoQFrontend.Endpoint.broadcast!("activity:#{model.id}", "delete:activity", payload)
    end
	end

end
