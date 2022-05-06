FROM ruby:2.7-alpine
WORKDIR /roomba-bot
COPY . /roomba-bot/
RUN gem update --system
RUN bundle install
WORKDIR /roomba-bot/bin
CMD ./roomba_walk
