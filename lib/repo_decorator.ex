defmodule Ragnar.RepoDecorator do
  alias Ragnar.Repo

  def insert_or_update!(struct, changeset) do
    case Repo.get_by(struct, symbol: changeset.changes.symbol) do
      nil   -> Repo.insert!(changeset)
      found ->
        Ecto.Changeset.change(found, changeset.changes)
        |> Repo.insert_or_update!
    end
  end

end
