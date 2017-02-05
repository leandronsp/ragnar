defmodule Ragnar.SerieView do
  use Ragnar.Web, :view

  def render("series.json", %{series: series}) do
    %{series: render_many(series, Ragnar.SerieView, "serie.json")}
  end

  def render("serie.json", %{serie: serie}) do
    %{symbol: serie.symbol, expires_at: serie.expires_at}
  end
end
