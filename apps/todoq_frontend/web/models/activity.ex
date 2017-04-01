defmodule TodoQFrontend.Activity do
  use TodoQFrontend.Web, :model
  use Arc.Ecto.Schema

  alias Ecto.Changeset

  schema "activities" do
    field :name, :string
    field :why, :string
    field :image, TodoQFrontend.ActivityIcon.Type
    field :color, :string
    field :avgDuration, :integer
    field :skippable, :boolean

    field :invest, :integer

    field :type, :string
    field :deadline, Ecto.DateTime
    field :frequency, :string

    field :lastDone, Ecto.DateTime

    field :randomPath, :string

    has_many :logs, TodoQFrontend.Log

    timestamps()
  end

  defp cast_type(%Changeset{changes: %{type: "frequency"}} = changeset, params), do: cast(changeset, params, [:frequency])
  defp cast_type(%Changeset{changes: %{type: "deadline"}} = changeset, params), do: cast(changeset, params, [:deadline])
  defp cast_type(changeset, _params), do: changeset

  defp validate_type(%Changeset{changes: %{type: "frequency"}} = changeset), do: validate_required(changeset, [:frequency])
  defp validate_type(%Changeset{changes: %{type: "deadline"}} = changeset), do: validate_required(changeset, [:deadline])
  defp validate_type(changeset), do: changeset

  defp put_random_path_on_create(%Changeset{changes: %{randomPath: nil}} = changeset), do: put_change(changeset, :randomPath, random_path())
  defp put_random_path_on_create(changeset), do: changeset

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :why, :color, :avgDuration, :skippable, :invest, :type])
    |> cast_type(params)
    |> put_random_path_on_create()
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :why, :color, :avgDuration, :skippable, :invest, :type])
    |> validate_type()
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end

  defp random_path() do
    {:ok, randomPathString} = Ecto.UUID.load(Ecto.UUID.bingenerate())
    randomPathString
  end

end
