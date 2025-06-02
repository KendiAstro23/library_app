#!/usr/bin/env bash
# exit on error
set -o errexit

# Remove any existing assets
rm -rf public/assets

# Install dependencies
bundle install

# Set up database
bundle exec rake db:migrate

# Precompile assets
RAILS_ENV=production bundle exec rake assets:precompile

# Clean assets only if precompile was successful
RAILS_ENV=production bundle exec rake assets:clean 