module RailsCodebook
  class Configuration
    
    attr_accessor :cb_key
    attr_accessor :cb_data_path

    def initialize
      @cb_data_path = ['']
      @cb_key = 'codebook'
    end

  end
end
