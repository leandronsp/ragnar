defmodule Ragnar.Repo.Migrations.CreateStock do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :symbol, :string
      add :last_update, :time
      add :price, :float
      add :variation, :float
      add :vh63, :float
      add :vh63_ibov, :float

      timestamps()
    end

  end
end
