FROM ruby:2.3.3

ENV RAILS_VERSION 4.2.7.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y build-essential --no-install-recommends

RUN apt-get update && apt-get install -y mysql-client postgresql-client postgresql \
	postgresql-contrib sqlite3 libxml2-dev libxslt1-dev imagemagick --no-install-recommends \
	ca-certificates bzip2 \
	&& rm -rf /var/lib/apt/lists/*

RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make -j8 && \
  CXX="g++ -Wno-unused-local-typedefs" make -j8 install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm eslint eslint-plugin-react yarn jsdom && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc


RUN mkdir /tmp/phantomjs \
	&& curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
       | tar -xj --strip-components=1 -C /tmp/phantomjs \
	&& mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

RUN gem install rails --version "$RAILS_VERSION"
