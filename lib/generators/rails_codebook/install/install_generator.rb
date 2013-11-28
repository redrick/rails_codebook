module RailsCodebook
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_default_seed
        template 'cb_initializer.rb.erb', 'config/initializers/rails_codebook.rb'
      end

    end
  end
end