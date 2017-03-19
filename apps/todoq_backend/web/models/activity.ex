defmodule TodoQ.Activity do
  use TodoQ.Web, :model
  use Arc.Ecto.Schema

  schema "activities" do
    field :name, :string
    field :why, :string
    field :image, TodoQ.ActivityIcon.Type
    field :color, :string
    field :avgDuration, :integer
    field :skippable, :boolean

    field :invest, :integer

    field :type, :string
    field :deadline, Ecto.DateTime
    field :frequency, :string

    field :lastDone, Ecto.DateTime

    field :randomPath, :string

    has_many :logs, TodoQ.Log

    timestamps()
  end

  defp validate_type(changeset) do
    type = get_field(changeset, :type)
    case type do
      "frequency" -> validate_required(changeset, [:frequency])
      "deadline" -> validate_required(changeset, [:deadline])
    end
  end

  defp cast_type(changeset, params) do
    case params do
      %{"type" => "frequency"} -> cast(changeset, params, [:frequency])
      %{"type" => "deadline"} -> cast(changeset, params, [:deadline])
    end
  end

  defp random_path() do
    {:ok, randomPathString} = Ecto.UUID.load(Ecto.UUID.bingenerate())
    randomPathString
  end

  defp put_random_path_on_create(changeset) do
    r = get_field(changeset, :randomPath)
    cond do
      is_nil(r) -> put_change(changeset, :randomPath, random_path())
      true -> changeset
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :why, :color, :avgDuration, :skippable, :invest, :type])
    |> cast_type(params)
    |> put_random_path_on_create()
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :why, :color, :avgDuration, :skippable, :invest])
    |> validate_type()
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end
end
