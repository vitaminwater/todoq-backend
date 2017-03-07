defmodule TodoQ.LogController do
  use TodoQ.Web, :controller

  alias TodoQ.Log

  def index(conn, _params) do
    logs = Repo.all(Log)
    render(conn, "index.json", logs: logs)
  end

  def create(conn, %{"log" => log_params, "activity_id" => activity_id}) do
    changeset = Log.changeset(%Log{activity_id: activity_id}, log_params)

    case Repo.insert(changeset) do
      {:ok, log} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", activity_log_path(conn, :show, activity_id, log))
        |> render("show.json", log: log)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TodoQ.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)
    render(conn, "show.json", log: log)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Repo.get!(Log, id)
    changeset = Log.changeset(log, log_params)

    case Repo.update(changeset) do
      {:ok, log} ->
        render(conn, "show.json", log: log)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TodoQ.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(log)

    send_resp(conn, :no_content, "")
  end
end
