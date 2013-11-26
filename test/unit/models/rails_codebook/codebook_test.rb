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

    test "cb_serialize" do
      serialized_codebook = @codebook.cb_serialize

      assert (serialized_codebook.class.to_s == "Hash")
    end

    test "serialize formats" do
      serialized = @codebook.cb_serialize :codebook_format
      value_serialized = @codebook.cb_serialize :collection_value
      id_serialized = @codebook.cb_serialize :collection_id
       
      assert (serialized == {id: @codebook.id, 
          value: @codebook.value, 
          name: I18n.t(@codebook.name), 
          cb_name: @codebook.cb_name, 
          created_at: @codebook.created_at, 
          updated_at: @codebook.updated_at, 
          sequence: @codebook.sequence,
          deleted: @codebook.deleted})
      assert (value_serialized == {value: @codebook.value, 
            name: I18n.t(@codebook.name)})
      assert (id_serialized == {id: @codebook.id, 
            name: I18n.t(@codebook.name)})
    end

    test "to_partial_path" do
      assert (@codebook.to_partial_path == "codebooks/codebook")
    end


  end


end