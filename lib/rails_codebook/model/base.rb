module RailsCodebook

  module Model
    
    class Base < RedisOrm::Base
      self.abstract_class = true

      # array  with value columns from the codebook
      def self.get_values
        self.all.map(&:value)
      end

      # array with name columns from the codebook
      def self.get_names
        self.all.map(&:name)
      end

      # searching through codebook with usage of i18n
      def self.search query_string, array=[]  
        self.all.each {|redis_row| array << redis_row.codebook_format if I18n.t(redis_row.name) =~ /#{query_string}/i }; array
      end

      def cb_serialize
        self.codebook_format
      end

      def codebook_format
        {
          id: self.id, 
          value: self.value, 
          name: I18n.t(self.name), 
          cb_name: self.cb_name, 
          created_at: self.created_at, 
          updated_at: self.updated_at, 
          sequence: self.sequence,
          deleted: self.deleted
        }
      end

      def to_partial_path
        "codebooks/codebook"
      end

      def self.digest_key(value)
        Digest::MD5.hexdigest(value)
      end
      
    end
  
  end

end