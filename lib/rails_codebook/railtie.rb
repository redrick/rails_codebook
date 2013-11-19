require 'rails_codebook'
require 'rails'

module RailsCodebook

  class Railtie < Rails::Railtie
    railtie_name :rails_codebook

    rake_tasks do
      load "tasks/rails_codebook.rake"
    end
  
  end

end