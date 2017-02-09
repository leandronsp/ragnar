defmodule Ragnar.BovespaClientTest do
  use ExUnit.Case
  alias Ragnar.BovespaClient, as: Client

  describe "#fetch_call_options" do
    test "fetches data given a share" do
      html    = Client.fetch_call_options!("PETR4")
      stock   = Ragnar.BovespaStockParser.parse_single(html)
      options = Ragnar.BovespaCallOptionsParser.parse_many(html, stock.changes)

      assert stock.valid?

      if length(options) > 0 do
        Enum.each(options, &(assert &1.valid?))
      end
    end
  end

  describe "#fetch_put_options" do
    test "fetches data given a share" do
      html    = Client.fetch_put_options!("PETR4")
      stock   = Ragnar.BovespaStockParser.parse_single(html, :put)
      options = Ragnar.BovespaPutOptionsParser.parse_many(html, stock.changes)

      assert stock.valid?

      if length(options) > 0 do
        Enum.each(options, &(assert &1.valid?))
      end
    end
  end

end
