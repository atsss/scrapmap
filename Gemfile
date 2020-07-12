source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.3'

gem 'jbuilder'
gem 'mysql2'
gem 'puma'
gem 'webpacker'

# View
gem 'slim-rails'

# Data/Model
gem 'active_interaction'

# Image
gem 'aws-sdk-s3', require: false
gem 'image_processing'

# Notification
gem 'slack-notifier'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'slim_lint', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end
