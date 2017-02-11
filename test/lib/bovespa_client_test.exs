defmodule Ragnar.BovespaClientTest do
  use ExUnit.Case
  alias Ragnar.BovespaClient, as: Client

  @tag external: true
  describe "#fetch_call_options" do
    test "fetches data given a share" do
      html    = Client.fetch_call_options!("PETR4")
      options = Ragnar.BovespaCallOptionsParser.parse_many(html)

      if length(options) > 0 do
        Enum.each(options, &(assert &1.valid?))
      end
    end
  end

  @tag external: true
  describe "#fetch_put_options" do
    test "fetches data given a share" do
      html    = Client.fetch_put_options!("PETR4")
      options = Ragnar.BovespaPutOptionsParser.parse_many(html)

      if length(options) > 0 do
        Enum.each(options, &(assert &1.valid?))
      end
    end
  end

end
