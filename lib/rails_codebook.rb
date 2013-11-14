require "rails_codebook/version"
require "rails_codebook/engine"

require "rails_codebook/model/base"
require "rails_codebook/controller/base"

module RailsCodebook
  extend self
 
  attr_accessor :redis
  @@redis = Redis.new

  def self.redis=(redis)
    @@redis = redis
    RedisOrm.redis = redis
  end

  def self.redis
    @@redis
  end
end

class Array
  def cb_serialize array=[]
    self.each { |row| array << row.cb_serialize }; array
  end
end

class NilClass
  def cb_serialize
    return {
      content: []
    }
  end
end