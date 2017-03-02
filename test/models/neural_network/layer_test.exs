defmodule Ragnar.NeuralNetwork.LayerTest do
  use Ragnar.ModelCase

  alias Ragnar.NeuralNetwork.Layer

  @valid_attrs %{weights: [[0.22, 0.42]], snashot_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Layer.changeset(%Layer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Layer.changeset(%Layer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
