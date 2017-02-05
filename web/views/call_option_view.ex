defmodule Ragnar.CallOptionView do
  use Ragnar.Web, :view

  def render("call_options.json", %{call_options: call_options}) do
    %{call_options: render_many(call_options, Ragnar.CallOptionView, "call_option.json")}
  end

  def render("call_option.json", %{call_option: call_option}) do
    %{
      symbol: call_option.symbol,
      last_update: call_option.last_update,
      price: call_option.price,
      strike: call_option.strike,
      trades: call_option.trades,
      serie_symbol: call_option.serie_symbol,
      stock_symbol: call_option.stock_symbol
    }
  end
end
