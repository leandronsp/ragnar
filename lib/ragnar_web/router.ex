defmodule RagnarWeb.Router do
  use RagnarWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", RagnarWeb do
    pipe_through :api

    get "/series", SerieController, :index
    get "/stocks", StockController, :index

    get "/stocks/:share/calls",           CallOptionController, :index
    get "/stocks/:share/calls/evaluated", CallOptionController, :evaluated

    get "/stocks/:share/puts", PutOptionController, :index

    post "/network/train", NeuralNetworkController, :train
    options "/network/train", NeuralNetworkController, :options
  end
end
