module RailsCodebook

  class Codebook < RailsCodebook::Model::Base
      
    # defining default attributes of codebook
    property :name, String
    property :value, String
    property :cb_name, String

    # defining indeces for search 
    index :name
    index :value
    index :cb_name
    
  end

end