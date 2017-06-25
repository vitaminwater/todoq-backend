defmodule Backend.ActivitiesTest do
  use Backend.DataCase

  alias Backend.Activities

  describe "activities" do
    alias Backend.Activities.Activity

    @upload_file %{__struct__: Plug.Upload, path: "test/assets/test.png", filename: "test.png"}

    @valid_attrs %{avgDuration: 42, color: "some color", image: @upload_file, frequency: "some frequency", invest: 42, name: "some name", randomPath: "some randomPath", skippable: true, type: "some type", why: "some why"}
    @update_attrs %{avgDuration: 43, color: "some updated color", image: @upload_file, frequency: "some updated frequency", invest: 43, name: "some updated name", randomPath: "some updated randomPath", skippable: false, type: "some updated type", why: "some updated why"}
    @invalid_attrs %{avgDuration: nil, color: nil, frequency: nil, invest: nil, name: nil, randomPath: nil, skippable: nil, type: nil, why: nil}

    def activity_fixture(attrs \\ %{}) do
      {:ok, activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activities.create_activity()

      activity
    end

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert Activities.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Activities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      assert {:ok, %Activity{} = activity} = Activities.create_activity(@valid_attrs)
      assert activity.avgDuration == 42
      assert activity.color == "some color"
      assert activity.frequency == "some frequency"
      assert activity.invest == 42
      assert activity.name == "some name"
      assert activity.randomPath == "some randomPath"
      assert activity.skippable == true
      assert activity.type == "some type"
      assert activity.why == "some why"
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      assert {:ok, activity} = Activities.update_activity(activity, @update_attrs)
      assert %Activity{} = activity
      assert activity.avgDuration == 43
      assert activity.color == "some updated color"
      assert activity.frequency == "some updated frequency"
      assert activity.invest == 43
      assert activity.name == "some updated name"
      assert activity.randomPath == "some updated randomPath"
      assert activity.skippable == false
      assert activity.type == "some updated type"
      assert activity.why == "some updated why"
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_activity(activity, @invalid_attrs)
      assert activity == Activities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Activities.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Activities.change_activity(activity)
    end
  end

  describe "logs" do
    alias Backend.Activities.Log

    @valid_attrs %{content: %{}, text: "some text", type: "some type"}
    @update_attrs %{content: %{}, text: "some updated text", type: "some updated type"}
    @invalid_attrs %{content: nil, text: nil, type: nil}

    def log_fixture(attrs \\ %{}) do
      {:ok, log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activities.create_log()

      log
    end

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Activities.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Activities.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      assert {:ok, %Log{} = log} = Activities.create_log(@valid_attrs)
      assert log.content == %{}
      assert log.text == "some text"
      assert log.type == "some type"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, log} = Activities.update_log(log, @update_attrs)
      assert %Log{} = log
      assert log.content == %{}
      assert log.text == "some updated text"
      assert log.type == "some updated type"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_log(log, @invalid_attrs)
      assert log == Activities.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Activities.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Activities.change_log(log)
    end
  end
end
