defmodule Ragnar.Serie do
  use RagnarWeb, :model

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

  def current(query) do
    from co in query, where: co.expires_at > from_now(0, "day")
  end
end
