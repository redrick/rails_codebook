module RailsCodebook

  module Model
    
    class Base < RedisOrm::Base
      
      # defining default attributes of codebook
      property :name, String
      property :value, String
      property :codebook_name, String

      # defining indeces for search 
      index :name
      index :value
      index :codebook_name

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
        self.all.each {|redis_row| array << redis_row if I18n.t(redis_row.name) =~ /#{query_string}/i }; array
      end

      # osobitna metoda na listovanie vsetkych moznosti, nech neifujem a pod, nech je to priamociare
      def self.all_codebookify array=[]
        self.all.each {|row| array << row.codebook_format}; array
      end

      # detto osobitna metoda na listovanie jednej moznosti, nech neifujem a pod, nech je to priamociare
      def self.codebookify id
        [self.find(id).codebook_format]
      end

      def codebook_format
        {value: self.value, name: I18n.t(self.name), codebook_name: self.codebook_name}
      end
      
    end
  
  end

end