#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Set up database
bundle exec rake db:create db:schema:load db:migrate

# Clean assets
rm -rf public/assets

# Precompile assets with explicit environment
RAILS_ENV=production bundle exec rake assets:precompile

# Skip assets:clean in production
# bundle exec rake assets:clean is removed since it's causing issues 