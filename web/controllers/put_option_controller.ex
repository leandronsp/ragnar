defmodule Ragnar.PutOptionController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, PutOption}

  def index(conn, params) do
    put_options = Repo.all(
      PutOption,
      stock_symbol: params["share"],
      serie_symbol: params["serie"]
    )

    render conn, "put_options.json", put_options: put_options
  end
end
