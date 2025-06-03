#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean assets
rm -rf public/assets

# Set up database and run migrations with explicit environment
RAILS_ENV=production bundle exec rake db:migrate 2>/dev/null || RAILS_ENV=production bundle exec rake db:setup

# Precompile assets with explicit environment
RAILS_ENV=production bundle exec rake assets:precompile

# Verify database connection
RAILS_ENV=production bundle exec rails runner 'ActiveRecord::Base.connection.execute("SELECT 1")'

# Skip assets:clean in production
# bundle exec rake assets:clean is removed since it's causing issues 