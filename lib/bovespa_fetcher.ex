require Logger

defmodule Ragnar.BovespaFetcher do
  alias Ragnar.Repo
  alias Ragnar.BovespaClient, as: Client

  def fetch_many! do
    shares = ["PETR4", "VALE5"]
    Enum.each(shares, &fetch_single!(&1))
  end

  def fetch_single!(stock_symbol) do
    Logger.info("Fetching for #{stock_symbol}...")

    html  = Client.fetch_call_options!(stock_symbol)
    stock = fetch_stock!(html)

    fetch_call_series!(html)
    fetch_call_options!(html, stock)

    html = Client.fetch_put_options!(stock_symbol)

    fetch_put_series!(html)
    fetch_put_options!(html, stock)
  end

  #### Private functions

  defp fetch_stock!(html) do
    Ragnar.BovespaStockParser.parse_single(html)
    |> insert_or_update!(Ragnar.Stock)
  end

  defp fetch_call_series!(html) do
    Ragnar.BovespaCallSeriesParser.parse_many(html)
    |> Enum.each(&insert_or_update!(&1, Ragnar.Serie))
  end

  defp fetch_call_options!(html, stock) do
    Ragnar.BovespaCallOptionsParser.parse_many(html, stock)
    |> Enum.each(&insert_or_update!(&1, Ragnar.CallOption))
  end

  defp fetch_put_options!(html, stock) do
    Ragnar.BovespaPutOptionsParser.parse_many(html, stock)
    |> Enum.each(&insert_or_update!(&1, Ragnar.PutOption))
  end

  defp fetch_put_series!(html) do
    Ragnar.BovespaPutSeriesParser.parse_many(html)
    |> Enum.each(&insert_or_update!(&1, Ragnar.Serie))
  end

  defp insert_or_update!(changeset, struct) do
    struct
    |> Repo.get_by(symbol: changeset.changes.symbol) || changeset
    |> Repo.insert_or_update!
  end

end
