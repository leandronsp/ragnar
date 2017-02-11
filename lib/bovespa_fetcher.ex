require Logger

defmodule Ragnar.BovespaFetcher do
  alias Ragnar.{Stock, Serie, CallOption, PutOption}

  alias Ragnar.BovespaClient,            as: Client
  alias Ragnar.RepoDecorator,            as: RepoDecorator
  alias Ragnar.BovespaStockParser,       as: StockParser
  alias Ragnar.BovespaCallSeriesParser,  as: CallSeriesParser
  alias Ragnar.BovespaPutSeriesParser,   as: PutSeriesParser
  alias Ragnar.BovespaCallOptionsParser, as: CallOptionsParser
  alias Ragnar.BovespaPutOptionsParser,  as: PutOptionsParser

  def fetch_many! do
    shares = ["PETR4", "VALE5", "ITUB4", "BVMF3", "BBDC4", "GGBR4", "CSNA3", "ITSA4", "BBAS3", "ABEV3", "CIEL3"]
    Enum.each(shares, &fetch_single!(&1))
  end

  def fetch_single!(share) do
    Logger.info("Fetching for #{share}...")

    share
    |> Client.fetch_options!(:call)
    |> parse_and_save_stock!
    |> parse_and_save_call_series!
    |> parse_and_save_call_options!

    share
    |> Client.fetch_options!(:put)
    |> parse_and_save_put_series!
    |> parse_and_save_put_options!
  end

  #### Private functions

  defp parse_and_save_stock!(html) do
    StockParser.parse_single(html)
    |> (&RepoDecorator.insert_or_update!(Stock, &1)).()
    html
  end

  defp parse_and_save_call_series!(html) do
    CallSeriesParser.parse_many(html)
    |> Enum.each(&RepoDecorator.insert_or_update!(Serie, &1))
    html
  end

  defp parse_and_save_call_options!(html) do
    CallOptionsParser.parse_many(html)
    |> Enum.each(&RepoDecorator.insert_or_update!(CallOption, &1))
    html
  end

  defp parse_and_save_put_options!(html) do
    PutOptionsParser.parse_many(html)
    |> Enum.each(&RepoDecorator.insert_or_update!(PutOption, &1))
    html
  end

  defp parse_and_save_put_series!(html) do
    PutSeriesParser.parse_many(html)
    |> Enum.each(&RepoDecorator.insert_or_update!(Serie, &1))
    html
  end

end
