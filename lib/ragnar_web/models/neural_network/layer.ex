defmodule Ragnar.NeuralNetwork.Layer do
  use RagnarWeb, :model

  schema "neural_network_layers" do
    field :weights, {:array, {:array, :float}}
    belongs_to :snapshot, Ragnar.NeuralNetwork.Snapshot
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:weights])
    |> cast_assoc(:snapshot)
    |> validate_required([:weights])
  end
end
