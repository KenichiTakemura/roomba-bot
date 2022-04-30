FROM ruby:2.7-alpine
WORKDIR /roomba-bot
COPY Gemfile /roomba-bot/Gemfile
RUN touch /roomba-bot/Gemfile.lock
RUN bundle install
