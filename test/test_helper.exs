ExUnit.configure exclude: [external: true]
ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Ragnar.Repo, :manual)

