# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.3.2"

gem "devise", ">= 4.7.3"
gem "kaminari", ">= 1.2.1"
gem "pundit"
gem "secure_headers"

# Error and performance monitoring
gem "sentry-delayed_job", ">= 4.5.1"
gem "sentry-rails", ">= 4.5.1"
gem "sentry-ruby", ">= 4.5.1"

# Cleaner logs, one line per request
gem "lograge", ">= 0.11.2"
gem "logstash-event"

# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"

# Use UUIDs as db primary key by default
gem "ar-uuid", "~> 0.2.1"

# Use Puma as the app server
gem "puma", "~> 5.3", ">= 5.3.1"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", ">= 5.2.1"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# Manage multiple processes i.e. web server and webpack
gem "foreman"

# Canonical meta tag
gem "canonical-rails", ">= 0.2.11"

gem "listen", ">= 3.0.5", "< 3.4"

# GOV.UK Notify
gem "mail-notify", ">= 1.0.3"

# do not rely on host's timezone data, which can be inconsistent
gem "tzinfo-data"

gem "activerecord-import", ">= 1.0.7"
gem "govuk-components", ">= 1.0.2"
gem "govuk_design_system_formbuilder", "~> 2.1", ">= 2.1.6"
gem "httpclient"
gem "json_api_client", ">= 0.9.6"
gem "rack-attack", ">=6.5.0"
gem "seed_dump", ">= 3.3.1"

# Database based asynchronous priority queue system
gem "daemons"
gem "delayed_cron_job"
gem "delayed_job_active_record", ">= 4.1.5"

platform :mswin, :mingw, :x64_mingw do
  gem "wdm", ">= 0.1.0"
end

gem "govspeak", git: "https://github.com/DFE-Digital/ecf-govspeak.git", ref: "b0202cdc4939b4ea29fbb5db3e11fa0a674663ec"

gem "acts_as_list"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # GOV.UK interpretation of rubocop for linting Ruby
  gem "rubocop-govuk", ">= 3.17.2"
  gem "scss_lint-govuk"

  # Debugging
  gem "pry-byebug"

  # Testing framework
  gem "rspec-rails", "~> 4.0.2"

  gem "cypress-on-rails", "~> 1.0"
  gem "database_cleaner-active_record", ">= 2.0.0"

  gem "dotenv-rails", ">= 2.7.6"

  gem "factory_bot_rails", ">= 6.1.0"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "faker"
  gem "pundit-matchers", "~> 1.6.0"
  gem "rails-controller-testing", ">= 1.0.5"
  gem "shoulda-matchers", "~> 4.4"
  gem "simplecov"
  gem "webdrivers", "~> 4.4", ">= 4.4.2"
  gem "webmock", ">= 3.10.0"
end
