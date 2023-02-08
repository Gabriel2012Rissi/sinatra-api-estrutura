#!/bin/sh
set -e

# Create database and run migrations
bundle exec rake db:create
bundle exec rake db:migrate

# If the environment is development or test, seed the database
if [ "${SINATRA_ENV}" = "development" ] || [ "${SINATRA_ENV}" = "test" ]; then
  bundle exec rake db:seed
fi

exec "$@"