defmodule Ragnar.BovespaPutSeriesParser do
  alias Ragnar.Serie
  use Ragnar.CommonParser

  def parse_many(html) do
    Floki.find(html, "table.serie tbody tr")
    |> Enum.map(&parse_single(&1))
  end

  ### Private functions

  defp parse_single(row) do
    cells = Floki.find(row, "td")

    build_changeset(%{
      symbol:     Enum.at(cells, 0) |> parse_raw_value,
      expires_at: Enum.at(cells, 7) |> parse_raw_value
    })
  end

  defp build_changeset(attrs) do
    Serie.changeset(%Serie{}, %{
      symbol:     attrs.symbol,
      expires_at: parse_date_value(attrs.expires_at, "%d/%m", %{shift_to_current_year: true})
    })
  end

end
