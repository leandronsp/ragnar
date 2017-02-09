defmodule Ragnar.Repo.Migrations.CreateCallOption do
  use Ecto.Migration

  def change do
    create table(:call_options) do
      add :symbol, :string, primary_key: true
      add :last_update, :utc_datetime
      add :strike, :float
      add :price, :float
      add :trades, :integer
      add :serie_symbol, :string
      add :stock_symbol, :string

      timestamps()
    end

  end
end
