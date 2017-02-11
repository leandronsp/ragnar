defmodule Ragnar.OptionsEvaluatorTest do
  use Ragnar.ConnCase

  alias Ragnar.{Stock, CallOption, PuOption, Serie}
  alias Ragnar.OptionsEvaluator

  test "evaluates call options" do
    capital = 100_000

    %{expires_at: Timex.today |> Timex.shift(days: 8)}
    |> build_serie

    %{price: 31.23, variation: 6.55, vh63: 59.04, vh63_ibov: 24.93}
    |> build_stock

    %{symbol: "C27", strike: 27.48, price: 4.45, trades: 31}
    |> build_call_option

    %{symbol: "C30", strike: 28.48, price: 3.65, trades: 19}
    |> build_call_option

    %{symbol: "C32", strike: 30.48, price: 2.32, trades: 432}
    |> build_call_option

    #OptionsEvaluator.evaluate_calls(call_options, stock, serie, capital)
  end

  test "evluates put options" do
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
