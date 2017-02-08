defmodule Ragnar.BovespaPutSeriesParser do
  alias Ragnar.Serie
  use Ragnar.CommonParser

  def parse_many(html) do
    rows = Floki.find(html, "table.serie tbody tr")
    Enum.map(rows, &parse_single(&1))
  end

  ### Private functions

  def parse_single(row) do
    cells = Floki.find(row, "td")

    serie = %Serie{
      symbol:     Enum.at(cells, 0) |> parse_raw_value,
      expires_at: Enum.at(cells, 7) |> parse_raw_value
    }

    build_serie_changeset(serie)
  end

  defp build_serie_changeset(serie) do
    attrs = %{
      symbol: serie.symbol,
      expires_at: parse_date_value(serie.expires_at, "%d/%m", %{shift_to_current_year: true})
    }

    Serie.changeset(%Serie{}, attrs)
  end

end
