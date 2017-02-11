defmodule Ragnar.CallOptionController do
  alias Ragnar.{Stock, Serie, CallOption}
  alias Ragnar.Repo
  alias Ragnar.OptionsEvaluator, as: Evaluator

  use Ragnar.Web, :controller

  def index(conn, params) do
    results = CallOption
    |> CallOption.query_by_share_and_serie(params["share"], params["serie"])
    |> Repo.all

    render conn, "call_options.json", call_options: results
  end

  def evaluated(conn, params) do
    stock   = Repo.get_by!(Stock, symbol: params["share"])
    serie   = Repo.get_by!(Serie, symbol: params["serie"])
    options = CallOption
    |> CallOption.query_by_share_and_serie(params["share"], params["serie"])
    |> Repo.all

    capital   = params["capital"] |> Integer.parse |> elem(0)
    evaluated = Evaluator.evaluate_calls(options, stock, serie, capital)

    render conn, "call_options_evaluated.json", call_options: evaluated
  end
end
