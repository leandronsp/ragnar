defmodule Ragnar.BovespaStockParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaStockParser, as: Parser

  test "parses stock" do
    {:ok, html} = File.read("test/fixtures/html/call_options.html")
    changeset = Parser.parse_single(html)

    assert changeset.valid?
    assert changeset.params["symbol"]      == "PETR4"
    assert changeset.params["price"]       == 15.34
    assert changeset.params["variation"]   == 3.02
    assert changeset.params["vh63"]        == 53.21
    assert changeset.params["vh63_ibov"]   == 24.34
    assert changeset.params["last_update"] == ~N[2017-02-03 18:12:00]
  end
end
