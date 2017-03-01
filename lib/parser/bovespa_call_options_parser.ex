defmodule Ragnar.BovespaCallOptionsParser do
  alias Ragnar.CallOption
  alias Ragnar.BovespaStockParser, as: StockParser

  use Ragnar.CommonParser

  def parse_many(html) do
    stock = StockParser.parse_single(html)

    Floki.find(html, "table.gregas tbody tr")
    |> Enum.map(&parse_single(&1, stock))
  end

  ### Private functions

  defp parse_single(row, stock) do
    cells = Floki.find(row, "td")

    build_changeset(%{
      symbol:       Enum.at(cells, 0) |> parse_raw_value,
      strike:       Enum.at(cells, 1) |> parse_raw_value,
      price:        Enum.at(cells, 2) |> parse_raw_value,
      trades:       Enum.at(cells, 3) |> parse_raw_value,
      serie_symbol: Enum.at(cells, 0) |> parse_raw_value |> String.at(0),
      stock_symbol: stock.changes.symbol,
      last_update:  stock.changes.last_update
    })
  end

  defp build_changeset(attrs) do
    CallOption.changeset(%CallOption{}, %{
      symbol:       attrs.symbol,
      strike:       parse_float_value(attrs.strike),
      price:        parse_float_value(attrs.price),
      trades:       parse_int_value(attrs.trades),
      stock_symbol: attrs.stock_symbol,
      serie_symbol: attrs.serie_symbol,
      last_update:  attrs.last_update
    })
  end

end
