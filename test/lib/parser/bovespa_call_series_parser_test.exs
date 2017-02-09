defmodule Ragnar.BovespaCallSeriesParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaCallSeriesParser, as: Parser

  test "parses call series" do
    {:ok, html} = File.read("test/fixtures/html/call_options.html")
    series = Parser.parse_many(html)

    assert length(series) == 3

    changeset = Enum.at(series, 0)
    assert changeset.valid?
    assert changeset.changes.symbol     == "B"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-02-20])

    changeset = Enum.at(series, 1)
    assert changeset.valid?
    assert changeset.changes.symbol     == "C"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-03-20])

    changeset = Enum.at(series, 2)
    assert changeset.valid?
    assert changeset.changes.symbol     == "D"
    assert changeset.changes.expires_at == Ecto.Date.cast!(~D[2017-04-17])
  end

end
