defmodule RagnarWeb.StockView do
  use RagnarWeb, :view

  def render("stocks.json", %{stocks: stocks}) do
    render_many(stocks, RagnarWeb.StockView, "stock.json")
  end

  def render("stock.json", %{stock: stock}) do
    %{
      symbol: stock.symbol,
      last_update: stock.last_update,
      price: stock.price,
      variation: stock.variation,
      vh63: stock.vh63,
      vh63_ibov: stock.vh63_ibov
    }
  end
end
