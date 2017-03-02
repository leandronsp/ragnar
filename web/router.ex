defmodule Ragnar.Router do
  use Ragnar.Web, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:9000"]
    plug :accepts, ["json"]
  end

  scope "/api", Ragnar do
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
