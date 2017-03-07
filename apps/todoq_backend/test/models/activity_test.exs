defmodule TodoQ.ActivityTest do
  use TodoQ.ModelCase

  alias TodoQ.Activity

  @valid_attrs %{avgDuration: 42, lastDone: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", priority: 42, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Activity.changeset(%Activity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Activity.changeset(%Activity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
