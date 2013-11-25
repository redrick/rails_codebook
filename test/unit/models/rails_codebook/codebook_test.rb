require 'test_helper'

module RailsCodebook
  
  class CodebookTest < ActiveSupport::TestCase

    before do
      @codebook = FactoryGirl.build(:codebook)
      @codebook.save
    end

    test "instance attrib+methods" do
      refute_empty @codebook.name
      refute_empty @codebook.value
      refute_empty @codebook.cb_name
      assert_equal @codebook.sequence, 100
      assert_equal @codebook.deleted, 0
      refute_empty @codebook.t_name
    end


    test "test set_created_at" do
      assert !!@codebook
      assert !!@codebook.created_at
    end

    test "test set_updated_at" do
      assert !!@codebook
      assert !!@codebook.updated_at
    end


    test "change updated_at" do
      updated_at = @codebook.updated_at.to_s
      sleep 2
      @codebook.save

      refute_equal updated_at, @codebook.updated_at
    end

    test "t_name" do
      translation = I18n.t @codebook.name
      assert_equal translation, @codebook.t_name
    end

  end


end