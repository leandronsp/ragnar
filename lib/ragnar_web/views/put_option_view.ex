defmodule RagnarWeb.PutOptionView do
  use RagnarWeb, :view

  def render("put_options.json", %{put_options: put_options}) do
    render_many(put_options, RagnarWeb.PutOptionView, "put_option.json")
  end

  def render("put_option.json", %{put_option: put_option}) do
    %{
      symbol: put_option.symbol,
      last_update: put_option.last_update,
      price: put_option.price,
      strike: put_option.strike,
      trades: put_option.trades,
      serie_symbol: put_option.serie_symbol,
      stock_symbol: put_option.stock_symbol
    }
  end
end
