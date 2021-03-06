defmodule Ragnar.SerieControllerTest do
  use   RagnarWeb.ConnCase
  alias Ragnar.Serie

  def expires_in(days) do
    Timex.today |> Timex.shift(days: days)
  end

  def expired_in(days) do
    Timex.today |> Timex.shift(days: -days)
  end

  describe "index/2" do
    test "responds with all the current series" do
      series = [
        Serie.changeset(%Serie{}, %{ symbol: "A", expires_at: expired_in(1)  }),
        Serie.changeset(%Serie{}, %{ symbol: "B", expires_at: expires_in(10) }),
        Serie.changeset(%Serie{}, %{ symbol: "C", expires_at: expires_in(40) }),
        Serie.changeset(%Serie{}, %{ symbol: "D", expires_at: expires_in(70) }),
      ]

      Enum.each(series, &Repo.insert!(&1))

      response = build_conn()
      |> get("/api/series")
      |> json_response(200)

      expected = [
        %{ "symbol" => "B", "expires_at" => expires_in(10) |> Date.to_string },
        %{ "symbol" => "C", "expires_at" => expires_in(40) |> Date.to_string },
        %{ "symbol" => "D", "expires_at" => expires_in(70) |> Date.to_string }
      ]

      assert response == expected
    end
  end

end
