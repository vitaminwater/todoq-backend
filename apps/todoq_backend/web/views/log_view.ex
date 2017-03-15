defmodule TodoQ.LogView do
  use TodoQ.Web, :view

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, TodoQ.LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, TodoQ.LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{id: log.id,
      text: log.text,
      type: log.type,
      content: log.content}
  end
end
