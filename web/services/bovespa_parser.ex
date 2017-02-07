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

  def build_stock_changeset(stock) do
    _parse_float = fn n ->
      String.replace(n, ",", ".")
      |> Float.parse
      |> elem(0)
    end

    _parse_date = fn d ->
      Timex.parse!(d, "%d/%m %H:%M", :strftime)
      |> Timex.shift(years: Timex.now.year)
    end

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

  def parse_raw_value(value) when value == nil, do: value

  def parse_raw_value(value) do
    Floki.text(value)
  end

  def parse_float_value(value) do
    String.replace(value, ",", ".")
    |> Float.parse
    |> elem(0)
  end

  def parse_date_value(value) do
    Timex.parse!(value, "%d/%m %H:%M", :strftime)
    |> Timex.shift(years: Timex.now.year)
  end

end
