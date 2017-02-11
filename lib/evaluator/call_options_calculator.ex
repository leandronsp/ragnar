defmodule Ragnar.CallOptionsCalculator do

  def remaining_days(serie) do
    case serie.expires_at.__struct__ == Ecto.Date do
      true  -> Ecto.Date.to_iso8601(serie.expires_at) |> Date.from_iso8601!
      false -> serie.expires_at
    end

    |> Timex.Comparable.diff(Timex.today, :days)
  end

  def future_volatility(stock, serie) do
    (stock.vh63 / 63) * remaining_days(serie)
    |> Float.round(2)
  end

  def rate(capital, stock, option) do
    (net_profit(capital, stock, option) / capital) * 100
    |> Float.round(2)
  end

  def annual_rate(capital, stock, option, serie) do
    (rate(capital, stock, option) / remaining_days(serie)) * 365
    |> Float.round(2)
  end

  def real_capital(capital, stock) do
    quantity(capital, stock) * stock.price
    |> Float.round(2)
  end

  def quantity(capital, stock) do
    (capital / stock.price) |> round |> subtract_remainder(100)
  end

  def cost_price(stock, option) do
    stock.price - option.price
  end

  def cost_operation(capital, stock, option) do
    cost_price(stock, option) * quantity(capital, stock)
  end

  def stop_loss(stock, option) do
    cost_price(stock, option) + 0.2
    |> Float.round(2)
  end

  def balance(stock, option) do
    ((stock.price - stop_loss(stock, option)) / stock.price) * 100
    |> Float.round(2)
  end

  def profit(:gross, capital, stock, option) do
    (option.strike - cost_price(stock, option)) * quantity(capital, stock)
    |> Float.round(2)
  end

  def profit(:net, capital, stock, option) do
    gross_profit(capital, stock, option) - tax(capital, stock, option) - operational_costs()
    |> Float.round(2)
  end

  def gross_profit(capital, stock, option) do
    profit(:gross, capital, stock, option)
  end

  def net_profit(capital, stock, option) do
    profit(:net, capital, stock, option)
  end

  def tax(capital, stock, option) do
    profit = gross_profit(capital, stock, option)
    costs  = operational_costs()

    case (profit - costs) > 0 do
      false -> 0.00
      true  -> (profit - costs) * 0.15 |> Float.round(2)
    end
  end

  def score(capital, stock, option, serie) do
    rate     = rate(capital, stock, option)
    balance  = balance(stock, option)
    fut_vol  = future_volatility(stock, serie)
    rem_days = remaining_days(serie)
    score    = (rate / rem_days) + (balance / fut_vol)

    case score do
      x when x < 0 -> 0
      y -> Float.round(y, 2)
    end
  end

  def rating(score) do
    cond do
      score > 2   -> "A"
      score > 1   -> "B"
      score > 0.3 -> "C"
      score > 0   -> "D"
      score == 0  -> "E"
    end
  end

  ### Private functions

  defp subtract_remainder(quantity, mod) do
    quantity - rem(quantity, mod)
  end

  defp operational_costs, do: 100

end
