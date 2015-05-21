FROM ruby:2.0

RUN apt-get update -qq
RUN apt-get install -y postgresql libpq-dev nodejs

RUN gem install rubygems-update --no-ri --no-rdoc
RUN update_rubygems

RUN mkdir app
ADD . /app

WORKDIR /app

RUN bundle install
RUN cp config/database.yml.example config/database.yml

EXPOSE 3000
