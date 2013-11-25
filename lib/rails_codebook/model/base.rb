require 'redis_orm'

module RailsCodebook

  module Model
    
    class Base < ::RedisOrm::Base
      self.abstract_class = true

      # universal regexp_search
      def self.search column_name='', value='', strict=false, init_cb=RailsCodebook::Codebook.all
        # binding.pry
        if column_name != ''
          strict ? \
            init_cb.select{|j| ((column_name == 'name') ? I18n.t(j.send(column_name)) : j.send(column_name)) =~ /^#{value}$/i} : \
            init_cb.select{|j| ((column_name == 'name') ? I18n.t(j.send(column_name)) : j.send(column_name)) =~ /(#{value})/i}
        else
          init_cb
        end
      end

      def cb_serialize format=:codebook_format
        format = :codebook_format if format.nil? 
        self.send(format)
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

      # possible formats for collection (selectbox style) : 
      #   collection_id
      #   collection_value
      # I dont see why anyone would use other.... :)
      ['id','value'].each do |attrib|
        define_method "collection_#{attrib}".to_sym do
          { 
            "#{attrib}".to_sym => self.send(attrib), 
            :name => I18n.t(self.name)
          }
        end
      end

      def to_partial_path
        "codebooks/codebook"
      end
      
    end
  
  end

end