defmodule Backend.Activities.Activity do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Backend.Activities.Activity


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "activities_activities" do
    field :name, :string
    field :why, :string
    field :image, Backend.Activities.ActivityIcon.Type
    field :color, :string
    field :avgDuration, :integer
    field :skippable, :boolean, default: false

    field :invest, :integer

    field :type, :string
    field :deadline, Ecto.DateTime
    field :frequency, :string

    field :lastDone, Ecto.DateTime

    field :randomPath, :string

    has_many :logs, Backend.Activities.Log

    timestamps()
  end

  defp cast_type(%Changeset{changes: %{type: "frequency"}} = changeset, attrs), do: cast(changeset, attrs, [:frequency])
  defp cast_type(%Changeset{changes: %{type: "deadline"}} = changeset, attrs), do: cast(changeset, attrs, [:deadline])
  defp cast_type(changeset, _attrs), do: changeset

  defp put_random_path_on_create(%Changeset{data: %Activity{randomPath: nil}} = changeset), do: put_change(changeset, :randomPath, random_path())
  defp put_random_path_on_create(changeset), do: changeset

  defp validate_type(%Changeset{changes: %{type: "frequency"}} = changeset), do: validate_required(changeset, [:frequency])
  defp validate_type(%Changeset{changes: %{type: "deadline"}} = changeset), do: validate_required(changeset, [:deadline])
  defp validate_type(changeset), do: changeset

  defp debug(changeset, attrs) do
    IO.inspect(changeset)
    IO.inspect(attrs)
    IO.inspect(File.exists?(attrs["image"].path))
    changeset
  end

  @doc false
  def changeset(%Activity{} = activity, attrs) do
    activity
    |> cast(attrs, [:name, :why, :color, :avgDuration, :skippable, :invest, :type, :frequency, :randomPath])
    |> cast_type(attrs)
    |> put_random_path_on_create()
    |> cast_attachments(attrs, [:image])
    |> debug(attrs)
    |> validate_required([:name, :why, :image, :color, :avgDuration, :skippable, :invest, :type, :frequency, :randomPath])
    |> validate_type()
    |> put_change(:lastDone, Ecto.DateTime.utc)
  end

  defp random_path() do
    {:ok, randomPathString} = Ecto.UUID.load(Ecto.UUID.bingenerate())
    randomPathString
  end
end
