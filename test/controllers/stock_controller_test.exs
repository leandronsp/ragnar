defmodule Ragnar.StockControllerTest do
  use   Ragnar.ConnCase
  alias Ragnar.Stock

  def last_update(hours) do
    Timex.now |> Timex.shift(hours: hours)
  end

  describe "index/2" do
    test "responds with all stocks" do
      stocks = [
        Stock.changeset(%Stock{}, %{
          symbol: "PETR4",
          last_update: last_update(-2),
          price: 15.45,
          variation: 3.65,
          vh63: 85.01,
          vh63_ibov: 34.00
        }),
        Stock.changeset(%Stock{}, %{
          symbol: "VALE5",
          last_update: last_update(-1),
          price: 30.33,
          variation: 0.90,
          vh63: 23.78,
          vh63_ibov: 34.00
        })
      ]

      Enum.each(stocks, &Repo.insert!(&1))

      response = build_conn()
      |> get("/api/stocks")
      |> json_response(200)

      all = Repo.all(Stock)

      expected = [
        %{
          "symbol" => "PETR4",
          "last_update" => List.first(all).last_update |> Ecto.DateTime.to_iso8601,
          "price" => 15.45,
          "variation" => 3.65,
          "vh63" => 85.01,
          "vh63_ibov" => 34.00
        },
        %{
          "symbol" => "VALE5",
          "last_update" => List.last(all).last_update |> Ecto.DateTime.to_iso8601,
          "price" => 30.33,
          "variation" => 0.90,
          "vh63" => 23.78,
          "vh63_ibov" => 34.00
        }
      ]

      assert response == expected
    end
  end

end
