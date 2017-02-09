defmodule Ragnar.BovespaFetcher do
  alias Ragnar.Repo
  alias Ragnar.BovespaClient, as: Client

  def fetch_single!(stock_symbol) do
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
    |> Repo.insert!
  end

  defp fetch_call_series!(html) do
    Ragnar.BovespaCallSeriesParser.parse_many(html)
    |> Enum.each(&Repo.insert!(&1))
  end

  defp fetch_call_options!(html, stock) do
    Ragnar.BovespaCallOptionsParser.parse_many(html, stock)
    |> Enum.each(&Repo.insert!(&1))
  end

  defp fetch_put_options!(html, stock) do
    Ragnar.BovespaPutOptionsParser.parse_many(html, stock)
    |> Enum.each(&Repo.insert!(&1))
  end

  defp fetch_put_series!(html) do
    Ragnar.BovespaPutSeriesParser.parse_many(html)
    |> Enum.each(&Repo.insert!(&1))
  end

end
