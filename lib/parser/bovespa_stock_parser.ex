require IEx
defmodule Ragnar.BovespaStockParser do
  alias Ragnar.Stock
  use Ragnar.CommonParser

  def parse_single(html, type \\ :call) do
    cells = Floki.find(html, "table.serie:nth-child(1), tbody tr td")
    attrs = %{
      symbol:      Enum.at(cells, 1) |> parse_raw_value,
      price:       Enum.at(cells, 2) |> parse_raw_value,
      variation:   Enum.at(cells, 3) |> parse_raw_value,
      vh63:        Enum.at(cells, 4) |> parse_raw_value,
      vh63_ibov:   Enum.at(cells, 5) |> parse_raw_value,
      last_update: Enum.at(cells, last_update_index(type)) |> parse_raw_value
    }

    build_changeset(attrs)
  end

  ### Private functions

  defp build_changeset(attrs) do
    Stock.changeset(%Stock{}, %{
      symbol: attrs.symbol,
      price: parse_float_value(attrs.price),
      variation: parse_float_value(attrs.variation),
      vh63: parse_float_value(attrs.vh63),
      vh63_ibov: parse_float_value(attrs.vh63_ibov),
      last_update: parse_datetime_value(attrs.last_update)
    })
  end

  defp last_update_index(:call), do: 9
  defp last_update_index(:put),  do: 8

end
