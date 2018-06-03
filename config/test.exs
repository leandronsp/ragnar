use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ragnar, RagnarWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ragnar, Ragnar.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "ragnar_test",
  username: "ragnar",
  hostname: System.get_env("PG_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
