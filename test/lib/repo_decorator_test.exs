defmodule Ragnar.RepoDecoratorTest do
  use Ragnar.ConnCase
  alias Ragnar.{Repo, RepoDecorator, Stock}

  @stock_attrs %{ symbol: "PETR4", last_update: Timex.now, price: 15.45, variation: 3.65, vh63: 85.01, vh63_ibov: 34.00 }

  describe "#insert_or_update!" do
    test "inserts newly data" do
      changeset = Stock.changeset(%Stock{}, @stock_attrs)
      RepoDecorator.insert_or_update!(Stock, changeset)

      assert Repo.all(Stock) |> length == 1
    end

    test "updates existent data" do
      changeset = Stock.changeset(%Stock{}, @stock_attrs)
      RepoDecorator.insert_or_update!(Stock, changeset)

      assert Repo.all(Stock) |> length == 1

      new_changeset = Stock.changeset(%Stock{}, Map.merge(@stock_attrs, %{price: 16.92}))
      RepoDecorator.insert_or_update!(Stock, new_changeset)

      assert Repo.all(Stock) |> length == 1

      stock = Repo.get_by(Stock, symbol: "PETR4")
      assert stock.price == 16.92
    end
  end

end
