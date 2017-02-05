defmodule Ragnar.CallOptionController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, CallOption}

  def index(conn, params) do
    call_options = Repo.all(
      CallOption,
      stock_symbol: params["share"],
      serie_symbol: params["serie"]
    )

    render conn, "call_options.json", call_options: call_options
  end
end
