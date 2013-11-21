ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)

require "rails/test_help"
require 'minitest/autorun'
require "minitest/rails/capybara"
require 'simplecov'
require 'coveralls'

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

class MiniTest::Spec
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include FactoryGirl::Syntax::Methods

  @@flag ||= nil

  unless @@flag
    @@flag = true
    FileUtils.rm_rf("#{Rails.root}/datafiles/test")
    load "#{Rails.root}/db/seeds.rb"
  end

end


class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

