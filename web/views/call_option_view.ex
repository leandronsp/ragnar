defmodule Ragnar.CallOptionView do
  use Ragnar.Web, :view

  def render("call_options.json", %{call_options: call_options}) do
    %{call_options: render_many(call_options, Ragnar.CallOptionView, "call_option.json")}
  end

  def render("call_options_evaluated.json", %{call_options: call_options}) do
    %{call_options: render_many(call_options, Ragnar.CallOptionView, "call_option_evaluated.json")}
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

  def render("call_option_evaluated.json", %{call_option: call_option}) do
    %{
      quantity: call_option.quantity,
      symbol: call_option.symbol,
      last_update: call_option.last_update,
      price: call_option.price,
      strike: call_option.strike,
      stock_price: call_option.stock_price,
      trades: call_option.trades,
      serie_symbol: call_option.serie_symbol,
      stock_symbol: call_option.stock_symbol,
      net_profit: call_option.net_profit,
      rate: call_option.rate,
      annual_rate: call_option.annual_rate,
      balance: call_option.balance,
      stop_loss: call_option.stop_loss,
      real_capital: call_option.real_capital,
      remaining_days: call_option.remaining_days,
      rating: call_option.rating,
      capital: call_option.capital
    }
  end
end
