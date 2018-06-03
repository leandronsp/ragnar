FROM elixir:latest
MAINTAINER leandronsp
COPY . /app
WORKDIR /app
RUN mix local.hex --force \
    mix local.rebar --force \
    mix deps.get \
    mix compile
