FROM elixir:latest
MAINTAINER leandronsp
COPY . /app
WORKDIR /app
RUN mix local.hex --force \
    mix local.rebar --force \
    mix deps.get \
    mix compile
CMD mix ecto.create && mix ecto.migrate && mix phx.server
EXPOSE 4000
