source 'http://rubygems.org'

# Base requirements
gem 'sinatra'

# Component requirements
gem 'coffee-script'
gem 'haml'
gem 'sass'
gem 'data_mapper', '1.2.0'
gem 'unicorn'

group :development do
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'pg'
  gem 'thin'
  gem 'dm-postgres-adapter'
end

# Testing requirements
group :test do
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'
  gem 'rr'
  gem 'riot'
  gem 'rack-test', :require => 'rack/test'
end