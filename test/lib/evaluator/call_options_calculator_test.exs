defmodule Ragnar.CallOptionsCalculatorTest do
  use ExUnit.Case
  alias Ragnar.{Stock, Serie, CallOption}
  alias Ragnar.CallOptionsCalculator, as: Calculator

  test "quantity/2" do
    stock = %Stock{price: 31.23}
    assert Calculator.quantity(100_000, stock) == 3200
  end

  test "cost_price/2" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{price: 4.45}

    assert Calculator.cost_price(stock, option) == 26.78
  end

  test "gross_profit/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.gross_profit(100_000, stock, option) == 2240.00
  end

  test "net_profit/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.net_profit(100_000, stock, option) == 1819.00
  end

  test "tax/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.tax(100_000, stock, option) == 321.00
  end

  test "real_capital/2" do
    stock  = %Stock{price: 31.23}
    assert Calculator.real_capital(100_000, stock) == 99936.00
  end

  test "rate/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.rate(100_000, stock, option) == 1.82
  end

  test "remaining_days/1" do
    serie = %Serie{expires_at: Timex.today |> Timex.shift(days: 42)}
    assert Calculator.remaining_days(serie) == 42

    serie = %Serie{expires_at: Timex.today |> Timex.shift(days: 18) |> Ecto.Date.cast!}
    assert Calculator.remaining_days(serie) == 18
  end

end
