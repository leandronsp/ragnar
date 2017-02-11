defmodule Ragnar.RepoDecorator do
  alias Ragnar.Repo

  def insert_or_update!(changeset) do
    case Repo.get_by(changeset.data.__struct__, symbol: changeset.changes.symbol) do
      nil   -> Repo.insert!(changeset)
      found ->
        Ecto.Changeset.change(found, changeset.changes)
        |> Repo.insert_or_update!
    end
  end

  def convert_to_map(struct) do
    Map.keys(struct) -- [:__meta__, :__struct__]
    |> (&Map.take(struct, &1)).()
  end

end
