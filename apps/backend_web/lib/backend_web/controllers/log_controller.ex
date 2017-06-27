defmodule Backend.Web.LogController do
  use Backend.Web, :controller

  alias Backend.Activities
  alias Backend.Activities.Log

  action_fallback Backend.Web.FallbackController

  def index(conn, %{"activity_id" => activity_id}) do
    logs = Activities.list_logs(activity_id)
    render(conn, "index.json", logs: logs)
  end

  def create(conn, %{"activity_id" => activity_id, "log" => log_params}) do
    with {:ok, %Log{} = log} <- Activities.create_log(activity_id, log_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", log_path(conn, :show, log))
      |> render("show.json", log: log)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Activities.get_log!(id)
    render(conn, "show.json", log: log)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Activities.get_log!(id)

    with {:ok, %Log{} = log} <- Activities.update_log(log, log_params) do
      render(conn, "show.json", log: log)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Activities.get_log!(id)
    with {:ok, %Log{}} <- Activities.delete_log(log) do
      send_resp(conn, :no_content, "")
    end
  end
end
