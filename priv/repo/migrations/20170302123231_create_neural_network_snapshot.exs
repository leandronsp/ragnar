defmodule Ragnar.Repo.Migrations.CreateNeuralNetwork.Snapshot do
  use Ecto.Migration

  def change do
    create table(:neural_network_snapshots) do
      timestamps()
    end

  end
end
