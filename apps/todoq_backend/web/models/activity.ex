defmodule TodoQ.Activity do
  use TodoQ.Web, :model
  use Arc.Ecto.Schema

  schema "activities" do
    field :name, :string
    field :why, :string
    field :image, Todoq.ActivityIcon.Type
    field :color, :string
    field :avgDuration, :integer
    field :skippable, :boolean

    field :invest, :integer

    field :deadline, Ecto.DateTime
    field :frequency, :string

    field :lastDone, Ecto.DateTime

    has_many :logs, TodoQ.Log

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :why, :color, :avgDuration])
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :why, :image, :color, :avgDuration])
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end
end
