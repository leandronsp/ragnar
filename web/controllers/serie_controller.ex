defmodule Ragnar.SerieController do
  use Ragnar.Web, :controller
  alias Ragnar.{Repo, Serie}

  def index(conn, _params) do
    series = Repo.all(Serie)
    render conn, "series.json", series: series
  end
end
