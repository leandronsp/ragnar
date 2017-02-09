defmodule Ragnar.BovespaCallOptionsParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaCallOptionsParser, as: Parser

  test "parses call options" do
    {:ok, html} = File.read("test/fixtures/html/call_options.html")

    stock_changeset = Ragnar.BovespaStockParser.parse_single(html)
    assert stock_changeset.valid?

    options = Parser.parse_many(html, stock_changeset.changes)

    assert length(options) == 106
    Enum.each(options, fn changeset -> assert changeset.valid? end)

    model = List.first(options).changes

    assert model.symbol       == "B10"
    assert model.last_update  == stock_changeset.changes.last_update
    assert model.strike       == 6.2
    assert model.price        == 9.1
    assert model.serie_symbol == "B"
    assert model.stock_symbol == "PETR4"
    assert model.trades       == 24

    model = List.last(options).changes

    assert model.symbol       == "D26"
    assert model.last_update  == stock_changeset.changes.last_update
    assert model.strike       == 26.0
    assert model.price        == 0.04
    assert model.serie_symbol == "D"
    assert model.stock_symbol == "PETR4"
    assert model.trades       == 4
  end

end
