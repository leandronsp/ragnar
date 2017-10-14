defmodule RagnarWeb.SerieController do
  use RagnarWeb, :controller
  alias Ragnar.{Repo, Serie}

  def index(conn, _params) do
    series = Repo.all(Serie)
    render conn, "series.json", series: series
  end
end
