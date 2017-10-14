# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ragnar,
  ecto_repos: [Ragnar.Repo]

# Configures the endpoint
config :ragnar, RagnarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SZsv1Rgy4FuTPc/u1Qj/3Tq0yyFWOqofk7MvX4GtZZ/WFXeoeafFLlzplbgoZdTP",
  render_errors: [view: RagnarWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ragnar.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#config :quantum, ragnar: [
#  cron: [
#    "* * * * *": {Ragnar.BovespaFetcher, :fetch_many!}
#  ]
#]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
