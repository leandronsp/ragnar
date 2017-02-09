defmodule Ragnar.BovespaClient do
  @url_encoded "aHR0cHM6Ly93d3cuYmFzdHRlci5jb20vTWVyY2Fkby9EYWRvcy9RdWFkcm9PcGNvZXMte3tzdG9ja319LXt7b3B0aW9uX3R5cGV9fS0xLmh0bWw/Y2FjaGU9e3tjYWNoZX19"
  @cache       "1457148847707"

  def fetch_call_options!(stock_symbol) do
    HTTPoison.start
    response = HTTPoison.get!(build_url(stock_symbol, :call), [], [ ssl: [{ :versions, [:'tlsv1.2']}] ])
    response.body
  end

  def fetch_put_options!(stock_symbol) do
    HTTPoison.start
    response = HTTPoison.get!(build_url(stock_symbol, :put), [], [ ssl: [{ :versions, [:'tlsv1.2']}] ])
    response.body
  end

  ### Private functions

  defp build_url(stock_symbol, :call) do
    Base.decode64!(@url_encoded)
    |> String.replace("{{stock}}", stock_symbol)
    |> String.replace("{{option_type}}", Base.decode64!("Q29tcHJh"))
    |> String.replace("{{cache}}", @cache)
  end

  defp build_url(stock_symbol, :put) do
    Base.decode64!(@url_encoded)
    |> String.replace("{{stock}}", stock_symbol)
    |> String.replace("{{option_type}}", Base.decode64!("VmVuZGE="))
    |> String.replace("{{cache}}", @cache)
  end

end
