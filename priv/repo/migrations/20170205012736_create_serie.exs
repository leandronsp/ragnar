defmodule Ragnar.Repo.Migrations.CreateSerie do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :symbol, :string, primary_key: true
      add :expires_at, :date

      timestamps()
    end

  end
end
