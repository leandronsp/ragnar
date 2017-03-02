defmodule Ragnar.NeuralNetworkController do

  use Ragnar.Web, :controller

  def train(conn, params) do
    inputs  = params["inputs"]
    targets = params["targets"]

    Ragnar.NeuralNetwork.train(inputs, targets)
    json conn, %{}
  end

end
