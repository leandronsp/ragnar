defmodule Ragnar.BovespaFetcherTest do
  use Ragnar.ConnCase

  alias Ragnar.{Stock, Serie, CallOption, PutOption}
  alias Ragnar.BovespaFetcher, as: Fetcher
  alias Ragnar.BovespaClient,  as: Client

  import Mock

  describe "#fetch_single!" do
    test "fetches stock, series and options given a share" do
      guess_source = fn(_, type) ->
        case type do
          :call -> File.read!("test/fixtures/html/call_options.html")
          :put  -> File.read!("test/fixtures/html/put_options.html")
        end
      end

      with_mock Client, [fetch_options!: guess_source] do
        Fetcher.fetch_single!("PETR4")

        assert called Client.fetch_options!("PETR4", :call)
        assert called Client.fetch_options!("PETR4", :put)

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
