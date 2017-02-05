defmodule Ragnar.StockController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, Stock}

  def index(conn, _params) do
    stocks = Repo.all(Stock)
    render conn, "stocks.json", stocks: stocks
  end
end
