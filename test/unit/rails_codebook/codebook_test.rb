require 'test_helper'

module RailsCodebook

  class CodebookTest < ActiveSupport::TestCase

    test "test set_created_at" do
      FactoryGirl.build(:codebook).save
      codebook = RailsCodebook::Codebook.all.first

      assert !!codebook
      assert !!codebook.created_at
    end

    test "test set_updated_at" do
      FactoryGirl.build(:codebook).save
      codebook = RailsCodebook::Codebook.all.first

      assert !!codebook
      assert !!codebook.updated_at
    end

  end

end