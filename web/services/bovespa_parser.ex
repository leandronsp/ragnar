defmodule Ragnar.BovespaParser do
  alias Ragnar.Stock

  def parse_stock(html) do
    row = Floki.find(html, "table.serie:nth-child(1), tbody tr td")

    stock = %Stock{
      symbol:      Enum.at(row, 1) |> parse_raw_value,
      price:       Enum.at(row, 2) |> parse_raw_value,
      last_update: Enum.at(row, 9) |> parse_raw_value,
      variation:   Enum.at(row, 3) |> parse_raw_value,
      vh63:        Enum.at(row, 4) |> parse_raw_value,
      vh63_ibov:   Enum.at(row, 5) |> parse_raw_value
    }

    build_stock_changeset(stock)
  end

  defp build_stock_changeset(stock) do
    attrs = %{
      symbol: stock.symbol,
      price: parse_float_value(stock.price),
      variation: parse_float_value(stock.variation),
      vh63: parse_float_value(stock.vh63),
      vh63_ibov: parse_float_value(stock.vh63_ibov),
      last_update: parse_date_value(stock.last_update)
    }

    Stock.changeset(%Stock{}, attrs)
  end

  defp parse_raw_value(value) when value == nil, do: value

  defp parse_raw_value(value) do
    Floki.text(value)
  end

  defp parse_float_value(value) do
    String.replace(value, ",", ".")
    |> Float.parse
    |> elem(0)
  end

  defp parse_date_value(value) do
    Timex.parse!(value, "%d/%m %H:%M", :strftime)
    |> Timex.shift(years: Timex.now.year)
  end

end
