defmodule Ragnar.CallOptionControllerTest do
  use   Ragnar.ConnCase
  alias Ragnar.CallOption

  def last_update(hours) do
    Timex.now |> Timex.shift(hours: hours) |> Ecto.DateTime.cast!
  end

  describe "index/2" do
    test "responds with all call options given a share and serie" do
      call_options = [
        CallOption.changeset(%CallOption{}, %{
          symbol: "C26",
          last_update: last_update(-2),
          strike: 26.00,
          price: 1.56,
          trades: 100,
          serie_symbol: "C",
          stock_symbol: "PETR4"
        }),
        CallOption.changeset(%CallOption{}, %{
          symbol: "B26",
          last_update: last_update(-2),
          strike: 26.00,
          price: 1.56,
          trades: 100,
          serie_symbol: "B",
          stock_symbol: "VALE5"
        }),
        CallOption.changeset(%CallOption{}, %{
          symbol: "B26",
          last_update: last_update(-2),
          strike: 26.00,
          price: 1.56,
          trades: 100,
          serie_symbol: "B",
          stock_symbol: "PETR4"
        }),
        CallOption.changeset(%CallOption{}, %{
          symbol: "B28",
          last_update: last_update(-2),
          strike: 28.00,
          price: 1.96,
          trades: 50,
          serie_symbol: "B",
          stock_symbol: "PETR4"
        })
      ]

      Enum.each(call_options, &Repo.insert!(&1))

      response = build_conn()
      |> get("/api/stocks/PETR4/calls?serie=B")
      |> json_response(200)

      query = CallOption.query_by_share_and_serie(CallOption, "PETR4", "B")
      all = Repo.all(query)

      expected = %{
        "call_options" => [
          %{
            "symbol" => "B26",
            "last_update" => List.first(all).last_update |> Ecto.DateTime.to_iso8601,
            "strike" => 26.00,
            "price" => 1.56,
            "trades" => 100,
            "serie_symbol" => "B",
            "stock_symbol" => "PETR4"
          },
          %{
            "symbol" => "B28",
            "last_update" => List.last(all).last_update |> Ecto.DateTime.to_iso8601,
            "strike" => 28.00,
            "price" => 1.96,
            "trades" => 50,
            "serie_symbol" => "B",
            "stock_symbol" => "PETR4"
          }
        ]
      }

      assert response == expected
    end
  end

end
