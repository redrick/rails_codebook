ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment", __FILE__)

require "rails/test_help"
require 'minitest/autorun'
require "minitest/rails/capybara"
require 'simplecov'
require 'coveralls'
require 'factory_girl'

Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
  add_filter "/script/"
end

FactoryGirl.definition_file_paths = %w(test/support/)
FactoryGirl.find_definitions

class ActionController::TestCase
  include RailsCodebook::Engine.routes.url_helpers
  include FactoryGirl::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
end