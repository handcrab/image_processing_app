FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev imagemagick

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

CMD puma -C config/puma.rb
