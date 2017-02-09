defmodule Ragnar.CallOption do
  use Ragnar.Web, :model
  import Ecto.Query, only: [from: 2]

  schema "call_options" do
    field :symbol, :string
    field :last_update, Ecto.DateTime
    field :strike, :float
    field :price, :float
    field :trades, :integer
    field :serie_symbol, :string
    field :stock_symbol, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:symbol, :last_update, :strike, :price, :trades, :serie_symbol, :stock_symbol])
    |> validate_required([:symbol, :last_update, :strike, :price, :trades, :serie_symbol, :stock_symbol])
  end

  def query_by_share_and_serie(query, share, serie) do
    from co in query, where: co.stock_symbol == ^share and co.serie_symbol == ^serie
  end
end
