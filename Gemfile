source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "rack-attack"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"
gem "tailwindcss-rails", "~> 4.0"

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem "pg"
end
