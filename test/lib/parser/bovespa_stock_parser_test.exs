defmodule Ragnar.BovespaStockParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaStockParser, as: Parser

  test "parses stock" do
    {:ok, html} = File.read("test/fixtures/html/call_options.html")
    changeset = Parser.parse_single(html)

    assert changeset.valid?
    assert changeset.changes.symbol      == "PETR4"
    assert changeset.changes.price       == 15.34
    assert changeset.changes.variation   == 3.02
    assert changeset.changes.vh63        == 53.21
    assert changeset.changes.vh63_ibov   == 24.34
    assert changeset.changes.last_update == Ecto.DateTime.cast!(~N[2018-02-03 18:12:00])
  end
end
