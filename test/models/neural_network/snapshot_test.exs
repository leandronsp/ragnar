defmodule Ragnar.NeuralNetwork.SnapshotTest do
  use Ragnar.ModelCase

  alias Ragnar.NeuralNetwork.Snapshot

  @valid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Snapshot.changeset(%Snapshot{}, @valid_attrs)
    assert changeset.valid?
  end

end
