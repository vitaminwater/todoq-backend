defmodule TodoQ.Log do
  use TodoQ.Web, :model

  schema "logs" do
    field :text, :string
    field :type, :string
    field :content, :map

    belongs_to :activity, TodoQ.Activity

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :type, :activity_id])
    |> validate_required([:content, :type, :activity_id])
    |> foreign_key_constraint(:activity_id)
  end
end
