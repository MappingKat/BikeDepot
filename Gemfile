source 'https://rubygems.org'

gem 'sinatra-contrib', require: 'sinatra/reloader'
gem 'sinatra', require: 'sinatra/base'
gem 'sequel'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'pry'
end

group :test do
  gem 'minitest', '>=5.0.0'
  gem 'rack-test'
  gem 'capybara'
  gem 'minitest-capybara'
end
