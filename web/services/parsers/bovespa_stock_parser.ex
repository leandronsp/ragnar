defmodule Ragnar.BovespaStockParser do
  alias Ragnar.Stock
  use Ragnar.CommonParser

  def parse_single(html) do
    cells = Floki.find(html, "table.serie:nth-child(1), tbody tr td")

    stock = %Stock{
      symbol:      Enum.at(cells, 1) |> parse_raw_value,
      price:       Enum.at(cells, 2) |> parse_raw_value,
      last_update: Enum.at(cells, 9) |> parse_raw_value,
      variation:   Enum.at(cells, 3) |> parse_raw_value,
      vh63:        Enum.at(cells, 4) |> parse_raw_value,
      vh63_ibov:   Enum.at(cells, 5) |> parse_raw_value
    }

    build_stock_changeset(stock)
  end

  ### Private functions

  defp build_stock_changeset(stock) do
    attrs = %{
      symbol: stock.symbol,
      price: parse_float_value(stock.price),
      variation: parse_float_value(stock.variation),
      vh63: parse_float_value(stock.vh63),
      vh63_ibov: parse_float_value(stock.vh63_ibov),
      last_update: parse_datetime_value(stock.last_update)
    }

    Stock.changeset(%Stock{}, attrs)
  end

end
