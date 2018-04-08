FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
RUN apt-get install nodejs -y
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN bundle install
