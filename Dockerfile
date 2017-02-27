FROM ruby:2.4-slim

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN bundle config --global frozen 1

RUN bundle config --global frozen 1; \
  apt-get update && apt-get install -qq -y \
  build-essential libpq-dev tzdata nodejs --no-install-recommends

WORKDIR /usr/scr/app


COPY Gemfile* ./
RUN bundle install

COPY . .
