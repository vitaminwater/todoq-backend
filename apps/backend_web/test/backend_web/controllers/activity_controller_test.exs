defmodule Backend.Web.ActivityControllerTest do
  use Backend.Web.ConnCase

  alias Backend.Activities
  alias Backend.Activities.Activity

  @create_attrs %{avgDuration: 42, color: "some color", image: "some image", frequency: "some frequency", invest: 42, name: "some name", randomPath: "some randomPath", skippable: true, type: "some type", why: "some why"}
  @update_attrs %{avgDuration: 43, color: "some updated color", image: "some image", frequency: "some updated frequency", invest: 43, name: "some updated name", randomPath: "some updated randomPath", skippable: false, type: "some updated type", why: "some updated why"}
  @invalid_attrs %{avgDuration: nil, color: nil, frequency: nil, invest: nil, name: nil, randomPath: nil, skippable: nil, type: nil, why: nil}

  def fixture(:activity) do
    {:ok, activity} = Activities.create_activity(@create_attrs)
    activity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, activity_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates activity and renders activity when data is valid", %{conn: conn} do
    conn = post conn, activity_path(conn, :create), activity: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, activity_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "avgDuration" => 42,
      "color" => "some color",
      "frequency" => "some frequency",
      "invest" => 42,
      "name" => "some name",
      "randomPath" => "some randomPath",
      "skippable" => true,
      "type" => "some type",
      "why" => "some why"}
  end

  test "does not create activity and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, activity_path(conn, :create), activity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen activity and renders activity when data is valid", %{conn: conn} do
    %Activity{id: id} = activity = fixture(:activity)
    conn = put conn, activity_path(conn, :update, activity), activity: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, activity_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "avgDuration" => 43,
      "color" => "some updated color",
      "frequency" => "some updated frequency",
      "invest" => 43,
      "name" => "some updated name",
      "randomPath" => "some updated randomPath",
      "skippable" => false,
      "type" => "some updated type",
      "why" => "some updated why"}
  end

  test "does not update chosen activity and renders errors when data is invalid", %{conn: conn} do
    activity = fixture(:activity)
    conn = put conn, activity_path(conn, :update, activity), activity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen activity", %{conn: conn} do
    activity = fixture(:activity)
    conn = delete conn, activity_path(conn, :delete, activity)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, activity_path(conn, :show, activity)
    end
  end
end
