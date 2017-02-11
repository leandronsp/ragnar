defmodule Ragnar.CallOptionController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, CallOption}

  def index(conn, params) do
    results = CallOption
    |> CallOption.query_by_share_and_serie(params["share"], params["serie"])
    |> Repo.all

    render conn, "call_options.json", call_options: results
  end

  def evaluated(conn, params) do
    results = CallOption
    |> CallOption.query_by_share_and_serie(params["share"], params["serie"])
    |> Repo.all

    render conn, "call_options_evaluated.json", call_options: results
  end
end
