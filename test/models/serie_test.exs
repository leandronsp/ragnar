defmodule Ragnar.SerieTest do
  use   Ragnar.ModelCase
  alias Ragnar.Serie

  @valid_attrs %{symbol: "A", expires_at: Timex.today}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Serie.changeset(%Serie{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Serie.changeset(%Serie{}, @invalid_attrs)
    refute changeset.valid?
  end

end
