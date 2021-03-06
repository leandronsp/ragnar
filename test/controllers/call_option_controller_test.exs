defmodule Ragnar.CallOptionControllerTest do
  use   RagnarWeb.ConnCase
  alias Ragnar.{Stock, Serie, CallOption}

  import Mock

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

      expected = [
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

      assert response == expected
    end
  end

  describe "evaluated/2" do
    test "calculates and returns the best options to do operation given a capital" do
      with_mock Ragnar.NeuralNetwork, [think: fn(_) -> 0.42 end] do
        %{expires_at: Timex.today |> Timex.shift(days: 36)}
        |> build_serie

        %{price: 31.23, variation: 6.55, vh63: 59.04, vh63_ibov: 24.93}
        |> build_stock

        %{symbol: "C27", strike: 27.48, price: 4.45, trades: 31}
        |> build_call_option

        %{symbol: "C28", strike: 28.42, price: 3.90, trades: 312, last_update: last_update(-25)}
        |> build_call_option

        response = build_conn()
        |> get("/api/stocks/SHARE/calls/evaluated?capital=100000&serie=C")
        |> json_response(200)

        assert length(response) == 1

        data = Enum.at(response, 0)
        assert data["annual_rate"] == 18.45
        assert data["balance"] == 13.61
        assert data["net_profit"] == 1_819.00
        assert data["price"] == 4.45
        assert data["quantity"] == 3_200
        assert data["capital"] == 100_000
        assert data["real_capital"] == 99_936.00
        assert data["serie_symbol"] == "C"
        assert data["rate"] == 1.82
        assert data["symbol"] == "C27"
        assert data["trades"] == 31
        assert data["remaining_days"] == 36
        assert data["stock_price"] == 31.23
        assert data["future_volatility"] == 33.74
      end
    end

    test "gets simple results for call options when capital is equal 0 (zero)" do
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
      |> get("/api/stocks/PETR4/calls/evaluated?serie=B&capital=0")
      |> json_response(200)

      query = CallOption.query_by_share_and_serie(CallOption, "PETR4", "B")
      all = Repo.all(query)

      expected = [
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

      assert response == expected
    end
  end

  def build_stock(attrs) do
    default = %{symbol: "SHARE", last_update: Timex.now}
    Stock.changeset(%Stock{}, Map.merge(default, attrs))
    |> Repo.insert!
  end

  def build_serie(attrs) do
    default = %{symbol: "C"}
    Serie.changeset(%Serie{}, Map.merge(default, attrs))
    |> Repo.insert!
  end

  def build_call_option(attrs) do
    default = %{stock_symbol: "SHARE", serie_symbol: "C", last_update: Timex.now}
    CallOption.changeset(%CallOption{}, Map.merge(default, attrs))
    |> Repo.insert!
  end

end
