ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment", __FILE__)

require "rails/test_help"
require 'minitest/autorun'
require "minitest/rails/capybara"
require 'simplecov'
require 'coveralls'
require 'factory_girl'

Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/test/'
  add_filter '/config/'
end

FactoryGirl.definition_file_paths = %w(test/factories test/dummy/test/factories)
FactoryGirl.find_definitions

# Run migrations
db_path = File.expand_path("../dummy/db/test.sqlite3/", __FILE__)
`rm #{db_path}` if File.exists?(db_path)
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)
load File.expand_path("../dummy/db/seeds.rb", __FILE__)

class ActionController::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
  include RailsCodebook::Engine.routes.url_helpers
end