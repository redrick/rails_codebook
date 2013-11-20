module RailsCodebook
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_default_seed
        template 'seeds.rb.erb', 'db/seeds/default_codebooks.rb'
      end

      def alter_seed_file
        File.open('db/seeds.rb', 'a') { |f| f.write("\n\nload \"\#{Rails.root}/db/seeds/default_codebooks.rb\"") }
      end

      def seed_it
        rake "db:seed"
      end

    end
  end
end