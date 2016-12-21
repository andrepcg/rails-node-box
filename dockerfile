FROM ruby:2.3.3

ENV RAILS_VERSION 4.2.7.1
ENV NODE_VERSION 7.2.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y build-essential --no-install-recommends

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y mysql-client postgresql-client postgresql yarn \
	postgresql-contrib sqlite3 libxml2-dev libxslt1-dev imagemagick ca-certificates bzip2 --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /root/.nvm
ENV NODE_DIR $NVM_DIR/versions/node/v$NODE_VERSION/
ENV PATH $NODE_DIR/bin:$NVM_DIR/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash && \
  echo 'source $NVM_DIR/nvm.sh' >> /etc/profile

RUN . $HOME/.nvm/nvm.sh && nvm install $NODE_VERSION && \
  nvm alias default $NODE_VERSION && \
  nvm use default && \
  echo 'source $NVM_DIR/versions/node/v$NODE_VERSION/bin/node' >> /etc/profile


RUN yarn global add eslint-plugin-react jsdom karma eslint

RUN mkdir /tmp/phantomjs \
	&& curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
       | tar -xj --strip-components=1 -C /tmp/phantomjs \
	&& mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

RUN gem install rails --version "$RAILS_VERSION"
