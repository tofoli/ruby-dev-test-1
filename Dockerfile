FROM ruby:3.1.1-alpine

WORKDIR /app

RUN apk --update add build-base git tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev imagemagick

COPY Gemfile Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

RUN gem install bundler -v 2.3.7

RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
