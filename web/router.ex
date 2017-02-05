defmodule Ragnar.Router do
  use Ragnar.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Ragnar do
    pipe_through :api

    resources "/series", SerieController, only: [:index]
    resources "/stocks", StockController, only: [:index]
  end
end
