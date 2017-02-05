defmodule Ragnar.PutOptionTest do
  use Ragnar.ModelCase

  alias Ragnar.PutOption

  @valid_attrs %{last_update: %{hour: 14, min: 0, sec: 0}, price: "120.5", serie_symbol: "some content", stock_symbol: "some content", strike: "120.5", symbol: "some content", trades: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PutOption.changeset(%PutOption{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PutOption.changeset(%PutOption{}, @invalid_attrs)
    refute changeset.valid?
  end
end
