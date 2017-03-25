defmodule TodoQFrontend.ActivityView do
  use TodoQFrontend.Web, :view

  def render("index.json", %{activities: activities}) do
    %{data: render_many(activities, TodoQFrontend.ActivityView, "activity.json")}
  end

  def render("show.json", %{activity: activity}) do
    %{data: render_one(activity, TodoQFrontend.ActivityView, "activity.json")}
  end

  def render("activity.json", %{activity: activity}) do
    %{id: activity.id,
      name: activity.name,
      why: activity.why,
      image: TodoQFrontend.ActivityIcon.url({activity.image, activity}),
      color: activity.color,
      avgDuration: activity.avgDuration,
      skippable: activity.skippable,
      invest: activity.invest,
      type: activity.type,
      deadline: activity.deadline,
      frequency: activity.frequency,
      lastDone: activity.lastDone}
  end
end
