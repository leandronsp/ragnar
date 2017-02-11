defmodule Ragnar.BovespaPutOptionsParserTest do
  use   ExUnit.Case
  alias Ragnar.BovespaPutOptionsParser, as: Parser

  test "parses put options" do
    {:ok, html} = File.read("test/fixtures/html/put_options.html")

    options = Parser.parse_many(html)

    assert length(options) == 41
    Enum.each(options, fn changeset -> assert changeset.valid? end)

    model = List.first(options).changes

    assert model.symbol       == "N19 E"
    assert model.last_update  == ~N[2017-02-03 18:12:00] |> Ecto.DateTime.cast!
    assert model.strike       == 9.7
    assert model.price        == 0.01
    assert model.serie_symbol == "N"
    assert model.stock_symbol == "PETR4"
    assert model.trades       == 1

    model = List.last(options).changes

    assert model.symbol       == "P45 E"
    assert model.last_update  == ~N[2017-02-03 18:12:00] |> Ecto.DateTime.cast!
    assert model.strike       == 15.5
    assert model.price        == 1.18
    assert model.serie_symbol == "P"
    assert model.stock_symbol == "PETR4"
    assert model.trades       == 1
  end

end
