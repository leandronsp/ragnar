defmodule Ragnar.OptionsEvaluatorTest do
  use Ragnar.ConnCase

  alias Ragnar.{Stock, CallOption, Serie}
  alias Ragnar.OptionsEvaluator, as: Evaluator

  import Mock

  test "evaluates call options" do
    with_mock Ragnar.NeuralNetwork, [think: fn(_) -> 0.42 end] do
      %{expires_at: Timex.today |> Timex.shift(days: 36)}
      |> build_serie

      %{price: 31.23, variation: 6.55, vh63: 59.04, vh63_ibov: 24.93}
      |> build_stock

      %{symbol: "C27", strike: 27.48, price: 4.45, trades: 31}
      |> build_call_option

      capital         = 100_000
      stock           = Repo.all(Stock) |> Enum.at(0)
      serie           = Repo.all(Serie) |> Enum.at(0)
      call_options    = Repo.all(CallOption)
      evaluated_calls = Evaluator.evaluate_calls(call_options, stock, serie, capital)

      evaluated = Enum.at(evaluated_calls, 0)

      assert evaluated.symbol       == "C27"
      assert evaluated.price        == 4.45
      assert evaluated.strike       == 27.48
      assert evaluated.rate         == 1.82
      assert evaluated.trades       == 31
      assert evaluated.balance      == 13.61
      assert evaluated.quantity     == 3_200
      assert evaluated.stop_loss    == 26.98
      assert evaluated.net_profit   == 1_819.00
      assert evaluated.annual_rate  == 18.45
      assert evaluated.real_capital == 99_936.00
    end
  end

  test "evaluates put options" do
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
