defmodule TodoQFrontend.LogView do
  use TodoQFrontend.Web, :view

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, TodoQFrontend.LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, TodoQFrontend.LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{id: log.id,
      text: log.text,
      type: log.type,
      content: log.content,
      inserted_at: log.inserted_at}
  end
end
