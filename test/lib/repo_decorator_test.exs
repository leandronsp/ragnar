defmodule Ragnar.RepoDecoratorTest do
  use RagnarWeb.ConnCase
  alias Ragnar.{Repo, RepoDecorator, Stock}

  @stock_attrs %{ symbol: "PETR4", last_update: Timex.now |> Ecto.DateTime.cast!, price: 15.45, variation: 3.65, vh63: 85.01, vh63_ibov: 34.00 }

  describe "insert_or_update!/1" do
    test "inserts newly data" do
      Stock.changeset(%Stock{}, @stock_attrs)
      |> RepoDecorator.insert_or_update!

      assert Repo.all(Stock) |> length == 1
    end

    test "updates existent data" do
      Stock.changeset(%Stock{}, @stock_attrs)
      |> RepoDecorator.insert_or_update!

      Stock.changeset(%Stock{}, %{@stock_attrs | price: 16.92})
      |> RepoDecorator.insert_or_update!

      assert Repo.all(Stock) |> length == 1

      Repo.get_by(Stock, symbol: "PETR4")
      |> (&assert(&1.price == 16.92)).()
    end
  end

end
