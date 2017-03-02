defmodule Ragnar.NeuralNetwork do
  alias Morphine.NeuralNetwork, as: Network
  alias Ragnar.NeuralNetwork.Snapshot, as: Snapshot

  def pid do
    [{Morphine.NeuralNetwork, pid, _, _}, _, _] =
    Supervisor.which_children(Ragnar.Supervisor)

    pid
  end

  def setup! do
    Network.setup_layers(pid(), [{4, 3}, {1, 4}])
    fetch_last_snapshot!() |> update_layers!()
  end

  def update_layers!(data) do
    layers = Enum.map(data, &Morphine.Layer.from_matrix/1)
    pid() |> Morphine.NeuralNetwork.update_layers!(layers)
  end

  def train(inputs, target, iterations \\ 100000) do
    targetz = ExAlgebra.Matrix.transpose(target)
    Network.learn(pid(), inputs, targetz, iterations)

    save_snapshot!()
  end

  def think(inputs) do
    Network.predict!(pid(), inputs)
  end

  def snapshot do
    matrix =
    pid()
    |> Network.get_layers
    |> Enum.map(&Morphine.Layer.to_matrix/1)

    Enum.map(matrix, &build_layer/1)
  end

  def build_layer(weights) do
    %{weights: weights}
  end

  def save_snapshot! do
    Snapshot.changeset(%Snapshot{}, %{layers: snapshot()})
    |> Ragnar.Repo.insert
  end

  def fetch_last_snapshot! do
    shot = Snapshot |> Ecto.Query.last |> Ragnar.Repo.one |> Ragnar.Repo.preload(:layers)
    if shot != nil, do: Snapshot.weights(shot), else: []
  end

end
