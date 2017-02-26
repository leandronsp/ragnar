defmodule Ragnar.NeuralNetwork do
  alias Morphine.NeuralNetwork, as: Network

  def pid do
    [{Morphine.NeuralNetwork, pid, _, _}, _, _] =
    Supervisor.which_children(Ragnar.Supervisor)

    pid
  end

  def setup! do
    Network.setup_layers(pid(), [{4, 3}, {1, 4}])
  end

  def train(inputs, target, iterations \\ 1000) do
    targetz = ExAlgebra.Matrix.transpose(target)
    Network.learn(pid(), inputs, targetz, iterations)
  end

  def think(inputs) do
    Network.predict!(pid(), inputs)
  end

end
