defmodule Bell.Ring do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rings" do
    timestamps()
  end

  @doc false
  def changeset(ring, attrs) do
    ring
    |> cast(attrs, [])
    |> validate_required([])
  end
end
