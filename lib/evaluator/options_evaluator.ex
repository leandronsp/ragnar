defmodule Ragnar.OptionsEvaluator do
  alias Ragnar.CallOptionsCalculator
  alias Ragnar.RepoDecorator

  def evaluate_calls(options, stock, serie, capital) do
    options
    |> Enum.map(&evaluate_single_option_call(&1, stock, serie, capital))
  end

  #### Private functions

  defp evaluate_single_option_call(option, stock, serie, capital) do
    RepoDecorator.convert_to_map(option)
    |> Map.merge(%{
      quantity: CallOptionsCalculator.quantity(capital, stock),
      rate: CallOptionsCalculator.rate(capital, stock, option),
      real_capital: CallOptionsCalculator.real_capital(capital, stock),
      stop_loss: CallOptionsCalculator.stop_loss(stock, option),
      net_profit: CallOptionsCalculator.net_profit(capital, stock, option),
      annual_rate: CallOptionsCalculator.annual_rate(capital, stock, option, serie),
      balance: CallOptionsCalculator.balance(stock, option),
      remaining_days: CallOptionsCalculator.remaining_days(serie),
      stock_price: stock.price
    })
  end

end