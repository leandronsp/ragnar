defmodule Ragnar.Repo.Migrations.CreateCallOption do
  use Ecto.Migration

  def change do
    create table(:call_options) do
      add :symbol, :string
      add :last_update, :time
      add :strike, :float
      add :price, :float
      add :trades, :integer
      add :serie_symbol, :string
      add :stock_symbol, :string

      timestamps()
    end

  end
end
