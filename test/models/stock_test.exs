defmodule Ragnar.StockTest do
  use   Ragnar.ModelCase
  alias Ragnar.Stock

  @valid_attrs %{
    symbol: "PETR4",
    last_update: Timex.now,
    price: 15.45,
    variation: 3.65,
    vh63: 85.01,
    vh63_ibov: 34.00
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stock.changeset(%Stock{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stock.changeset(%Stock{}, @invalid_attrs)
    refute changeset.valid?
  end

end
