defmodule Ragnar.BovespaPutSeriesParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaPutSeriesParser, as: Parser

  test "parses put series" do
    {:ok, html} = File.read("test/fixtures/html/put_options.html")
    series = Parser.parse_many(html)

    assert length(series) == 3

    changeset = Enum.at(series, 0)
    assert changeset.valid?
    assert changeset.params["symbol"]     == "N"
    assert changeset.params["expires_at"] == ~D[2017-02-20]

    changeset = Enum.at(series, 1)
    assert changeset.valid?
    assert changeset.params["symbol"]     == "O"
    assert changeset.params["expires_at"] == ~D[2017-03-20]

    changeset = Enum.at(series, 2)
    assert changeset.valid?
    assert changeset.params["symbol"]     == "P"
    assert changeset.params["expires_at"] == ~D[2017-04-17]
  end

end
