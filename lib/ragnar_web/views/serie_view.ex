defmodule RagnarWeb.SerieView do
  use RagnarWeb, :view

  def render("series.json", %{series: series}) do
    render_many(series, RagnarWeb.SerieView, "serie.json")
  end

  def render("serie.json", %{serie: serie}) do
    %{symbol: serie.symbol, expires_at: serie.expires_at}
  end
end
