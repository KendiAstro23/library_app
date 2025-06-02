#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Set up database and run migrations
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

# Clean assets
rm -rf public/assets

# Precompile assets with explicit environment
RAILS_ENV=production bundle exec rake assets:precompile

# Verify database connection
bundle exec rails runner 'ActiveRecord::Base.connection.execute("SELECT 1")'

# Skip assets:clean in production
# bundle exec rake assets:clean is removed since it's causing issues 