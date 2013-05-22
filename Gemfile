source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'globalize3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem "pg"
  gem 'unicorn'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.11.0'
  gem 'factory_girl_rails', '4.1.0'
end

group :development do
  # Generate UML Diagrams
  gem 'railroady'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'guard-rspec'
  gem 'launchy'
  
  gem 'simplecov', :require => false
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'turbo-sprockets-rails3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'
gem 'spree', :git => 'http://github.com/spree/spree.git', :tag => 'v2.0.0.rc1'
gem 'spree_gateway', :git => 'http://github.com/spree/spree_gateway', :branch => '2-0-stable'
gem 'spree_auth_devise', :git => 'http://github.com/spree/spree_auth_devise', :branch => '2-0-stable'

# gem 'spree_14rank', :path => '../spree_14rank'
gem 'spree_14rank', :git => 'https://github.com/14bis/14rank.git'