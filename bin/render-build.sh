#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean assets
rm -rf public/assets

# Set up database and run migrations with explicit environment
RAILS_ENV=production bundle exec rake db:drop || true
RAILS_ENV=production bundle exec rake db:create
RAILS_ENV=production bundle exec rake db:schema:load
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake db:seed

# Precompile assets with explicit environment
RAILS_ENV=production bundle exec rake assets:precompile

# Verify database connection
RAILS_ENV=production bundle exec rails runner 'ActiveRecord::Base.connection.execute("SELECT 1")'

# Skip assets:clean in production
# bundle exec rake assets:clean is removed since it's causing issues 