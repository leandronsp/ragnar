defmodule Ragnar.PutOptionController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, PutOption}

  def index(conn, params) do
    results = PutOption
    |> PutOption.query_by_share_and_serie(params["share"], params["serie"])
    |> Repo.all

    render conn, "put_options.json", put_options: results
  end
end
