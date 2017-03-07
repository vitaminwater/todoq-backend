defmodule TodoQ.Activity do
  use TodoQ.Web, :model

  schema "activities" do
    field :name, :string
    field :type, :string
    field :avgDuration, :integer
    field :lastDone, Ecto.DateTime
    field :priority, :integer

    has_many :logs, TodoQ.Log

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type, :priority])
    |> validate_required([:name, :type, :priority])
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end
end
