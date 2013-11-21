require 'test_helper'

class RailsCodebooksTest < ActiveSupport::TestCase

  test "array cb_serialize" do
    codebooks = []
    4.times do 
      codebooks << FactoryGirl.build(:codebook)
    end

    assert_equal [].cb_serialize, []
    assert_instance_of Array, codebooks.cb_serialize
  end
  
  test "hash cb_serialize" do
    codebooks = []
    4.times do 
      codebooks << FactoryGirl.build(:codebook)
    end

    assert_instance_of Array, {}.cb_serialize
    assert_instance_of Array, codebooks.cb_serialize
  end

  test "nilclass cb_serialize" do
    assert_equal nil.cb_serialize, {:content=>[]}
  end

  test "redis configuration" do
    RailsCodebook.redis = Redis.new(db:15)
    assert_equal  RailsCodebook.redis, RedisOrm.redis 
  end

end