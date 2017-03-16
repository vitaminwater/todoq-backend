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

    field :deadline, Ecto.DateTime
    field :frequency, :string

    field :lastDone, Ecto.DateTime

    field :randomPath, :string

    has_many :logs, TodoQ.Log

    timestamps()
  end

  defp validate_type(changeset, params) do
    case params do
      %{"type" => "frequency"} -> validate_required(changeset, [:frequency])
      %{"type" => "deadline"} -> validate_required(changeset, [:deadline])
    end
  end

  defp cast_type(changeset, params) do
    case params do
      %{"type" => "frequency"} -> cast(changeset, params, [:frequency])
      %{"type" => "deadline"} -> cast(changeset, params, [:deadline])
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    {:ok, randomPathString} = Ecto.UUID.load(Ecto.UUID.bingenerate())
    struct
    |> cast(params, [:name, :why, :color, :avgDuration, :skippable, :invest])
    |> cast_type(params)
    |> put_change(:randomPath, randomPathString)
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :why, :color, :avgDuration, :skippable, :invest])
    |> validate_type(params)
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end
end
