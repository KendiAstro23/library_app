FROM ruby:3.3

# Install OS packages
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  sqlite3 \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gem dependencies and install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy all app code
COPY . .

# Precompile assets (if needed)
RUN bundle exec bootsnap precompile --gemfile || true

# Set default port
EXPOSE 3000

# Start the app
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
