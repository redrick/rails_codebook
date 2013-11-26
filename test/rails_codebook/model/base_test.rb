require 'test_helper'

module RailsCodebook

  module Model

    class BaseTest < ActiveSupport::TestCase

      test "search" do
        count1 = RailsCodebook::Model::Base.search.count
        count2 = RailsCodebook::Codebook.all.count

        assert (count1 == count2)
      end
    end

  end

end