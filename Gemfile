source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'sqlite3'
gem 'jquery-rails'

gem 'rabl'
gem 'haml'

gem 'simplecov'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'therubyracer'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl', '2.2.0'
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions  
  gem 'database_cleaner' # to clear Cucumber's test database between runs
# gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
end

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "pickler", "~> 0.2.1"
end

group :test do
  # Pretty printed test output
  gem 'turn', '< 0.8.3', :require => false
  gem 'cucumber-rails'
end
