defmodule Ragnar.Serie do
  use Ragnar.Web, :model

  schema "series" do
    field :symbol, :string
    field :expires_at, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:symbol, :expires_at])
    |> validate_required([:symbol, :expires_at])
  end
end
