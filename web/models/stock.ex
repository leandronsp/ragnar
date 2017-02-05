defmodule Ragnar.Stock do
  use Ragnar.Web, :model

  schema "stocks" do
    field :symbol, :string
    field :last_update, Ecto.Time
    field :price, :float
    field :variation, :float
    field :vh63, :float
    field :vh63_ibov, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:symbol, :last_update, :price, :variation, :vh63, :vh63_ibov])
    |> validate_required([:symbol, :last_update, :price, :variation, :vh63, :vh63_ibov])
  end
end
