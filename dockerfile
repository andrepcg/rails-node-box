FROM ruby:2.3.3

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y build-essential --no-install-recommends

RUN apt-get update && apt-get install -y mysql-client postgresql-client postgresql \
	postgresql-contrib sqlite3 libxml2-dev libxslt1-dev imagemagick --no-install-recommends \
	ca-certificates bzip2 \
	&& rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

ENV NODE_VERSION 7.2.1

ENV NVM_DIR /usr/local/nvm

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm set progress=false \
    && npm install -g eslint eslint-plugin-react

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN mkdir /tmp/phantomjs \
	&& curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
       | tar -xj --strip-components=1 -C /tmp/phantomjs \
	&& mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

ENV RAILS_VERSION 4.2.7.1

RUN gem install rails --version "$RAILS_VERSION"
