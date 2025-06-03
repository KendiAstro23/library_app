#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies with frozen mode disabled
bundle config set --local frozen false
bundle install

# Clean assets
rm -rf public/assets

# Database setup function
setup_database() {
  local cmd=$1
  local desc=$2
  echo "Running $desc..."
  RAILS_ENV=production bundle exec rake $cmd || {
    echo "Failed to run $desc"
    return 1
  }
}

# Set up database and run migrations with explicit environment
echo "Starting database setup..."

# Drop database if it exists
echo "Attempting to drop database..."
RAILS_ENV=production bundle exec rake db:drop 2>/dev/null || true

# Create and setup database
setup_database "db:create" "database creation" && \
setup_database "db:schema:load" "schema load" && \
setup_database "db:migrate" "migrations" && \
setup_database "db:seed" "database seeding"

# Verify database setup
echo "Verifying database setup..."
RAILS_ENV=production bundle exec rails runner '
begin
  puts "Checking database connection..."
  ActiveRecord::Base.connection.execute("SELECT 1")
  
  puts "Verifying users table..."
  if ActiveRecord::Base.connection.table_exists?(:users)
    user_count = User.count
    puts "Users table exists with #{user_count} records"
  else
    puts "Users table does not exist!"
    exit 1
  end

  puts "Verifying other essential tables..."
  required_tables = [:books, :borrowings, :saved_books, :sessions]
  missing_tables = required_tables.reject { |table| ActiveRecord::Base.connection.table_exists?(table) }
  
  if missing_tables.empty?
    puts "All required tables exist!"
  else
    puts "Missing tables: #{missing_tables.join(", ")}"
    exit 1
  end
rescue => e
  puts "Database verification failed: #{e.message}"
  puts e.backtrace
  exit 1
end
'

# Precompile assets
echo "Precompiling assets..."
RAILS_ENV=production bundle exec rake assets:precompile

echo "Build completed successfully!" 