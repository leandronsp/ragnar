defmodule RagnarWeb.SerieController do
  use RagnarWeb, :controller
  alias Ragnar.{Repo, Serie}

  def index(conn, _params) do
    results = Serie
    |> Serie.current()
    |> Repo.all

    render conn, "series.json", series: results
  end
end
