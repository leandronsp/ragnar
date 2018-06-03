FROM elixir:latest
MAINTAINER leandronsp
COPY . /app
WORKDIR /app
RUN apt update
RUN apt install inotify-tools -y
RUN mix local.hex --force \
    mix local.rebar --force \
    mix deps.get \
    mix compile
