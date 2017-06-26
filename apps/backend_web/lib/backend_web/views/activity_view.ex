defmodule Backend.Web.ActivityView do
  use Backend.Web, :view
  alias Backend.Web.ActivityView

  def render("index.json", %{activities: activities}) do
    %{data: render_many(activities, ActivityView, "activity.json")}
  end

  def render("show.json", %{activity: activity}) do
    %{data: render_one(activity, ActivityView, "activity.json")}
  end

  def render("activity.json", %{activity: activity}) do
    %{id: activity.id,
      name: activity.name,
      why: activity.why,
      image: Backend.Activities.ActivityIcon.url({activity.image, activity}, :thumb),
      color: activity.color,
      avgDuration: activity.avgDuration,
      skippable: activity.skippable,
      invest: activity.invest,
      type: activity.type,
      deadline: activity.deadline,
      frequency: activity.frequency,
      randomPath: activity.randomPath}
  end
end
