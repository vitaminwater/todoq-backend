defmodule Backend.Web.LogControllerTest do
  use Backend.Web.ConnCase

  alias Backend.Activities
  alias Backend.Activities.Log

  @create_attrs %{content: %{}, text: "some text", type: "some type"}
  @update_attrs %{content: %{}, text: "some updated text", type: "some updated type"}
  @invalid_attrs %{content: nil, text: nil, type: nil}

  def fixture(:log) do
    {:ok, log} = Activities.create_log(@create_attrs)
    log
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, log_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates log and renders log when data is valid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, log_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "content" => %{},
      "text" => "some text",
      "type" => "some type"}
  end

  test "does not create log and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen log and renders log when data is valid", %{conn: conn} do
    %Log{id: id} = log = fixture(:log)
    conn = put conn, log_path(conn, :update, log), log: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, log_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "content" => %{},
      "text" => "some updated text",
      "type" => "some updated type"}
  end

  test "does not update chosen log and renders errors when data is invalid", %{conn: conn} do
    log = fixture(:log)
    conn = put conn, log_path(conn, :update, log), log: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen log", %{conn: conn} do
    log = fixture(:log)
    conn = delete conn, log_path(conn, :delete, log)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, log_path(conn, :show, log)
    end
  end
end
