defmodule Ragnar.PutOptionControllerTest do
  use   Ragnar.ConnCase
  alias Ragnar.PutOption

  def last_update(hours) do
    Timex.now |> Timex.shift(hours: hours)
  end

  describe "index/2" do
    test "responds with all put options given a share and serie" do
      put_options = [
        PutOption.changeset(%PutOption{}, %{
          symbol: "C26",
          last_update: last_update(-2),
          strike: 26.00,
          price: 1.56,
          trades: 100,
          serie_symbol: "C",
          stock_symbol: "PETR4"
        }),
        PutOption.changeset(%PutOption{}, %{
          symbol: "B26",
          last_update: last_update(-2),
          strike: 26.00,
          price: 1.56,
          trades: 100,
          serie_symbol: "B",
          stock_symbol: "PETR4"
        }),
        PutOption.changeset(%PutOption{}, %{
          symbol: "B28",
          last_update: last_update(-2),
          strike: 28.00,
          price: 1.96,
          trades: 50,
          serie_symbol: "B",
          stock_symbol: "PETR4"
        })
      ]

      Enum.each(put_options, &Repo.insert!(&1))

      response = build_conn()
      |> get("/api/stocks/PETR4/puts?serie=B")
      |> json_response(200)

      query = PutOption.query_by_share_and_serie(PutOption, "PETR4", "B")
      all = Repo.all(query)

      expected = %{
        "put_options" => [
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
