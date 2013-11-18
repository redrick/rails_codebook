module RailsCodebook

  class Codebook < RailsCodebook::Base

    before_create :set_created_at
    before_save :set_updated_at


    # defining default attributes of codebook
    # name -> i18n hook for name that is being displayed
    property :name, String
    # value -> parametrized name or some string that can identifie it and alse can be put in url
    property :value, String
    # cb_name -> name of actual codebook !important!
    property :cb_name, String
    # created_at -> sets when the row is created
    property :created_at, DateTime
    # updated_at -> updates everytime you move with row
    property :updated_at, DateTime
    # sequence -> used for sorting
    property :sequence, Integer, default: 100
    # deleted -> only those set to 0 are shown (thers are "deleted")
    property :deleted, Integer, default: 0

    # defining indeces for search 
    index :name
    index :value
    index :cb_name
    index :created_at
    index :updated_at
    index :sequence
    index :deleted

    private

      def set_created_at
        self.created_at = Time.now.to_s(:db)
      end
    
      def set_updated_at
        self.updated_at = Time.now.to_s(:db)
      end
      
  end

end