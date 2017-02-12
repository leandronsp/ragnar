defmodule Ragnar.OptionsEvaluator do
  alias Ragnar.CallOptionsCalculator
  alias Ragnar.RepoDecorator

  def evaluate_calls(options, stock, serie, capital) do
    options
    |> Enum.map(&evaluate_single_option_call(&1, stock, serie, capital))
    |> Enum.filter(&(&1.rate > 0 && &1.balance > 0))
    |> Enum.sort_by(&(&1.strike), &<=/2)
  end

  #### Private functions

  defp evaluate_single_option_call(option, stock, serie, capital) do
    RepoDecorator.convert_to_map(option)
    |> Map.merge(%{
      capital:           capital,
      stock_price:       stock.price,
      quantity:          CallOptionsCalculator.quantity(capital, stock),
      rate:              CallOptionsCalculator.rate(capital, stock, option),
      real_capital:      CallOptionsCalculator.real_capital(capital, stock),
      stop_loss:         CallOptionsCalculator.stop_loss(stock, option),
      net_profit:        CallOptionsCalculator.net_profit(capital, stock, option),
      annual_rate:       CallOptionsCalculator.annual_rate(capital, stock, option, serie),
      balance:           CallOptionsCalculator.balance(stock, option),
      score:             CallOptionsCalculator.score(capital, stock, option, serie),
      rating:            CallOptionsCalculator.score(capital, stock, option, serie) |> CallOptionsCalculator.rating,
      remaining_days:    CallOptionsCalculator.remaining_days(serie),
      future_volatility: CallOptionsCalculator.future_volatility(stock, serie)
    })
  end

end
