defmodule Ragnar.BovespaFetcherTest do
  use Ragnar.ConnCase

  alias Ragnar.{Stock, Serie, CallOption, PutOption}
  alias Ragnar.BovespaFetcher, as: Fetcher
  alias Ragnar.BovespaClient,  as: Client

  import Mock

  describe "#fetch_single!" do
    test "fetches stock, series and options given a share" do
      {:ok, calls_html} = File.read("test/fixtures/html/call_options.html")
      {:ok, puts_html}  = File.read("test/fixtures/html/put_options.html")

      fetch_calls = {Client, [], [fetch_call_options!: fn(_) -> calls_html end]}
      fetch_puts  = {Client, [], [fetch_put_options!: fn(_) -> puts_html end]}

      with_mocks([fetch_calls, fetch_puts]) do
        Fetcher.fetch_single!("PETR4")

        assert called Client.fetch_call_options!("PETR4")
        assert called Client.fetch_put_options!("PETR4")

        assert Repo.all(Stock)      |> length == 1
        assert Repo.all(Serie)      |> length == 6
        assert Repo.all(CallOption) |> length == 106
        assert Repo.all(PutOption)  |> length == 41

        #### Fetches twice but does not duplicate rows!
        Fetcher.fetch_single!("PETR4")

        assert Repo.all(Stock)      |> length == 1
        assert Repo.all(Serie)      |> length == 6
        assert Repo.all(CallOption) |> length == 106
        assert Repo.all(PutOption)  |> length == 41
      end
    end

  end
end
