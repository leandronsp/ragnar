defmodule Ragnar.BovespaCallOptionsParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaCallOptionsParser, as: Parser

  test "parses call options" do
    {:ok, html} = File.read("test/fixtures/html/call_options.html")
    #series = Parser.parse_many(html)

    #assert length(series) == 3

    #changeset = Enum.at(series, 0)
    #assert changeset.valid?
    #assert changeset.params["symbol"]     == "B"
    #assert changeset.params["expires_at"] == ~D[2017-02-20]

    #changeset = Enum.at(series, 1)
    #assert changeset.valid?
    #assert changeset.params["symbol"]     == "C"
    #assert changeset.params["expires_at"] == ~D[2017-03-20]

    #changeset = Enum.at(series, 2)
    #assert changeset.valid?
    #assert changeset.params["symbol"]     == "D"
    #assert changeset.params["expires_at"] == ~D[2017-04-17]
  end

end
