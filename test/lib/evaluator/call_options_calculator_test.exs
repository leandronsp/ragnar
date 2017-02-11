defmodule Ragnar.CallOptionsCalculatorTest do
  use ExUnit.Case
  alias Ragnar.{Stock, Serie, CallOption}
  alias Ragnar.CallOptionsCalculator, as: Calculator

  test "quantity/2" do
    stock = %Stock{price: 31.23}
    assert Calculator.quantity(100_000, stock) == 3_200
  end

  test "cost_price/2" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{price: 4.45}

    assert Calculator.cost_price(stock, option) == 26.78
  end

  test "gross_profit/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.gross_profit(100_000, stock, option) == 2_240.00
  end

  test "net_profit/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.net_profit(100_000, stock, option) == 1_819.00
  end

  test "tax/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.tax(100_000, stock, option) == 321.00
  end

  test "real_capital/2" do
    stock  = %Stock{price: 31.23}
    assert Calculator.real_capital(100_000, stock) == 99_936.00
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

  test "annual_rate/4" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}
    serie = %Serie{expires_at: Timex.today |> Timex.shift(days: 36)}

    assert Calculator.annual_rate(100_000, stock, option, serie) == 18.45
  end

  test "stop_loss/2" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.stop_loss(stock, option) == 26.98
  end

  test "balance/2" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.balance(stock, option) == 13.61
  end

  test "cost_operation/3" do
    stock  = %Stock{price: 31.23}
    option = %CallOption{strike: 27.48, price: 4.45}

    assert Calculator.cost_operation(100_000, stock, option) == 85_696.00
  end

  test "future_volatility/2" do
    stock  = %Stock{price: 31.23, vh63: 59.04}
    serie = %Serie{expires_at: Timex.today |> Timex.shift(days: 36)}

    assert Calculator.future_volatility(stock, serie) == 33.74
  end

  test "score/4" do
    stock  = %Stock{price: 31.23, vh63: 59.04}
    option = %CallOption{strike: 27.48, price: 4.45}
    serie = %Serie{expires_at: Timex.today |> Timex.shift(days: 36)}

    assert Calculator.score(100_000, stock, option, serie) == 0.45
  end

  test "rating/1" do
    assert Calculator.rating(2.1) == "A"
    assert Calculator.rating(1.1) == "B"
    assert Calculator.rating(0.4) == "C"
    assert Calculator.rating(0.1) == "D"
    assert Calculator.rating(0.0) == "E"
  end

end
