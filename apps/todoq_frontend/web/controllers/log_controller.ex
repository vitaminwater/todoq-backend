defmodule TodoQFrontend.LogController do
  use TodoQFrontend.Web, :controller

  alias TodoQFrontend.Log

  def index(conn, %{"activity_id" => activity_id}) do
    logs = Repo.all(from u in Log, where: u.activity_id == ^activity_id)
    render(conn, "index.json", logs: logs)
  end

  def create(conn, %{"log" => log_params, "activity_id" => activity_id}) do
    changeset = %Log{activity_id: activity_id}
                |> Log.changeset(log_params)

    case BroadcastRepo.insert(changeset) do
      {:ok, log} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", log_path(conn, :show, log))
        |> render("show.json", log: log)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TodoQFrontend.ChangesetView, "error.json", changeset: changeset)
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
        |> render(TodoQFrontend.ChangesetView, "error.json", changeset: changeset)
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
