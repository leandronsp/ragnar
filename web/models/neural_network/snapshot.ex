defmodule Ragnar.NeuralNetwork.Snapshot do
  use Ragnar.Web, :model

  schema "neural_network_snapshots" do
    has_many :layers, Ragnar.NeuralNetwork.Layer
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> cast_assoc(:layers)
    |> validate_required([])
  end

  def weights(snapshot) do
    Enum.map(snapshot.layers, &(&1.weights))
  end
end
