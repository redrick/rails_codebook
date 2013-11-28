require 'test_helper'

module RailsCodebook

  class EngineTest < ActiveSupport::TestCase

    test "initialize_content" do
      before = RailsCodebook::Codebook.find_all_by_cb_name('some_codebook').count

      RailsCodebook::Engine.initialize_content

      after = RailsCodebook::Codebook.find_all_by_cb_name('some_codebook').count

      assert before != after, "got before: #{before}, got after: #{after}"
      assert before == 0, "got before: #{before}, got after: #{after}"
      assert after == 3, "got before: #{before}, got after: #{after}"
    end
  
  end

end