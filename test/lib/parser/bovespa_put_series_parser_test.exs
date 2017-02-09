defmodule Ragnar.BovespaPutSeriesParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaPutSeriesParser, as: Parser

  test "parses put series" do
    {:ok, html} = File.read("test/fixtures/html/put_options.html")
    series = Parser.parse_many(html)

    assert length(series) == 3

    changeset = Enum.at(series, 0)
    assert changeset.valid?
    assert changeset.changes.symbol     == "N"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-02-20])

    changeset = Enum.at(series, 1)
    assert changeset.valid?
    assert changeset.changes.symbol     == "O"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-03-20])

    changeset = Enum.at(series, 2)
    assert changeset.valid?
    assert changeset.changes.symbol     == "P"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-04-17])
  end

end
