defmodule Ragnar.BovespaFetcherTest do
  use Ragnar.ConnCase

  alias Ragnar.{Stock, Serie, CallOption, PutOption}
  alias Ragnar.BovespaFetcher, as: Fetcher
  alias Ragnar.BovespaClient,  as: Client

  import Mock

  test "#fetch_single!" do
    {:ok, calls_html} = File.read("test/fixtures/html/call_options.html")
    {:ok, puts_html}  = File.read("test/fixtures/html/put_options.html")

    fetch_calls = {Client, [], [fetch_call_options!: fn(_) -> calls_html end]}
    fetch_puts  = {Client, [], [fetch_put_options!: fn(_) -> puts_html end]}

    with_mocks([fetch_calls, fetch_puts]) do
      Fetcher.fetch_single!("PETR4")
      assert called Client.fetch_call_options!("PETR4")
      assert called Client.fetch_put_options!("PETR4")

      stocks = Repo.all(Stock)
      assert length(stocks) == 1

      series = Repo.all(Serie)
      assert length(series) == 6

      options = Repo.all(CallOption)
      assert length(options) == 106

      options = Repo.all(PutOption)
      assert length(options) == 41
    end
  end

end
