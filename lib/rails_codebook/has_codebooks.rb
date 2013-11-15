class << ActiveRecord::Base

  def has_codebooks params={}
    
    params.each do |column_name, codebook_name|

      base_method_name = column_name.gsub('_cb', '')

      # method for getting the one row referenced from model as object (something_object)
      define_method (base_method_name+'_object').to_sym do |hash={}|
        all = RailsCodebook::Codebook.find(:all, conditions: {cb_name: codebook_name})
        all.each {|row| return row if row.value == self.send(column_name) }; hash
      end

      # method for getting the one row referenced from model as json (something)
      define_method base_method_name.to_sym do
        self.send(base_method_name+'_object').cb_serialize
      end    

      # method for getting all possible values of codebook or the column given (something_all)
      define_method (base_method_name+'_all').to_sym do
        RailsCodebook::Codebook.find(:all, conditions: {cb_name: codebook_name }).cb_serialize
      end    

      # method for getting the array of i18ned names of cb rows (something_names)
      define_singleton_method (base_method_name+'_names').to_sym do |array=[]|
        RailsCodebook::Codebook.find(:all, conditions: {cb_name: codebook_name }).each {|cb| array << I18n.t(cb.name) }; array
      end      

      # method for getting the array of values of cb rows (something_values)
      define_singleton_method (base_method_name+'_values').to_sym do
        RailsCodebook::Codebook.find(:all, conditions: {cb_name: codebook_name }).map(&:value)
      end      

    end

  end

end