FROM ruby:2.3.3

RUN apt-get update && apt-get install -y build-essential nodejs npm --no-install-recommends

RUN apt-get update && apt-get install -y mysql-client postgresql-client postgresql \
	postgresql-contrib sqlite3 libxml2-dev libxslt1-dev imagemagick --no-install-recommends \
	ca-certificates bzip2 \
	&& rm -rf /var/lib/apt/lists/*

RUN npm set progress=false \
	&& npm install -g eslint yarn eslint-plugin-react \

RUN mkdir /tmp/phantomjs \
	&& curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
       | tar -xj --strip-components=1 -C /tmp/phantomjs \
	&& mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

ENV RAILS_VERSION 4.2.7.1

RUN gem install rails --version "$RAILS_VERSION"
