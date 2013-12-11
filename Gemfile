source 'http://rubygems.org'
ruby "1.9.2"

gem 'rails'
gem 'mongoid'
gem 'bson_ext'
gem 'nested_form', :git => "git://github.com/ryanb/nested_form.git"

gem "redcarpet"
gem 'bson_ext'
gem 'jquery-rails'
#gem "twitter-bootstrap-rails"
gem "truncate_html"
gem "rack-cache"
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'rmagick'
gem "fog", "~> 1.3.1"
gem 'tinymce-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "3.1.5"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
group :production do
  gem "thin"
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem "pry-rails"
  gem "pry-nav"
  # Pretty printed test output
  #gem 'turn', :require => false
end