# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_codebook/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_codebook"
  spec.version       = RailsCodebook::VERSION
  spec.authors       = ["redrick"]
  spec.email         = ["andrej.antas@gmail.com"]
  spec.description   = "Codebook solution we all use in our projects"
  spec.summary       = "Codebook solution we all use in our projects."
  spec.homepage      = "https://github.com/redrick/rails_codebook"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  
  spec.add_dependency "rails", "~> 4.0.0"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "jquery-ui-rails"
  spec.add_dependency 'uglifier'
  spec.add_dependency 'will_paginate'
  spec.add_dependency "less-rails"
  spec.add_dependency 'twitter-bootstrap-rails'
  spec.add_dependency 'sqlite3'

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "minitest-rails"
  spec.add_development_dependency "capybara" #, '2.0.2'
  spec.add_development_dependency "minitest-rails-capybara"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "turn"

  spec.add_dependency "rake"
end
