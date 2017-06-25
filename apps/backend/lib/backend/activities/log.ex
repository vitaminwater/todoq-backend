defmodule Backend.Activities.Log do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Activities.Log


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "activities_logs" do
    field :text, :string
    field :type, :string
    field :content, :map

    belongs_to :activity, Backend.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(%Log{} = log, attrs) do
    log
    |> cast(attrs, [:text, :type, :content])
    |> validate_required([:text, :type, :content])
  end
end
