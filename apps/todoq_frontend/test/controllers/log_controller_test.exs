defmodule TodoQFrontend.LogControllerTest do
  use TodoQFrontend.ConnCase

  alias TodoQFrontend.Log
  @valid_attrs %{content: %{}, type: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, log_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = get conn, log_path(conn, :show, log)
    assert json_response(conn, 200)["data"] == %{"id" => log.id,
      "content" => log.content,
      "type" => log.type}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, log_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Log, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = put conn, log_path(conn, :update, log), log: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Log, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = put conn, log_path(conn, :update, log), log: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = delete conn, log_path(conn, :delete, log)
    assert response(conn, 204)
    refute Repo.get(Log, log.id)
  end
end
