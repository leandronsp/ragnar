defmodule Ragnar.BovespaClientTest do
  use ExUnit.Case
  alias Ragnar.BovespaClient, as: Client

  @tag external: true
  test "fetches call options" do
    html    = Client.fetch_options!("PETR4", :call)
    options = Ragnar.BovespaCallOptionsParser.parse_many(html)

    if length(options) > 0 do
      Enum.each(options, &(assert &1.valid?))
    end
  end

  @tag external: true
  test "fetches put options" do
    html    = Client.fetch_options!("PETR4", :put)
    options = Ragnar.BovespaPutOptionsParser.parse_many(html)

    if length(options) > 0 do
      Enum.each(options, &(assert &1.valid?))
    end
  end

end
