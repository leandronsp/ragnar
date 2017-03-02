defmodule Ragnar.Repo.Migrations.CreateNeuralNetwork.Layer do
  use Ecto.Migration

  def change do
    create table(:neural_network_layers) do
      add :snapshot_id, references(:neural_network_snapshots)
      add :weights, {:array, {:array, :float}}

      timestamps()
    end

  end
end
