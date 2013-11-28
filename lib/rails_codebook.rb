require "redis"
require 'twitter-bootstrap-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'will_paginate'

require "rails_codebook/version"
require "rails_codebook/engine"
require "rails_codebook/has_codebooks"
require "rails_codebook/acts_as_codebook"
require "rails_codebook/configuration"

require "rails_codebook/model/base"
require "rails_codebook/controller/base"


module RailsCodebook
  extend self

  attr_accessor :redis

  @@redis = Redis.new

  def redis=(value)
    @@redis = value
    RedisOrm.redis = @@redis
  end

  def redis
    @@redis
  end
  
  class ConfigurationError < StandardError
  end

  def self.configure(&block)
    block.call(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

end

class Array
  def cb_serialize format=:codebook_format, array=[]
    self.each { |row| array << row.cb_serialize(format) }; array
  end
end

class Hash
  def cb_serialize format=:codebook_format, array=[]
    self.each { |row| array << row.cb_serialize(format) }; array
  end
end

class NilClass
  def cb_serialize format=:codebook_format
    return {
      content: []
    }
  end
end