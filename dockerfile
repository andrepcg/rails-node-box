FROM ruby:2.3

RUN apt-get update && apt-get install -y build-essential nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 4.2.7.1

RUN gem install rails --version "$RAILS_VERSION"
