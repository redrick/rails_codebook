class << ActiveRecord::Base

  # defining simple rules for codebook method generation
  #  class Project < ActiveRecord::Base
  #    acts_as_codebook({
  #      "method"     => "method_base_name",         // base name to which suffixes will be added
  #                                                  // otherwise model_name will be used
  #      "value"      => "clo_name_for_value", 
  #      "key"        => "clo_name_for_key"
  #    })
  #  end
  def acts_as_codebook params={}, options={}

    ##
    #
    # self _values [a,b,c]
    # self _keys   [1,2,3]
    # self _cb_all {{cb},{cb},{cb}}
    # _cb_object {cb}
    # 
    ##

    base_method_name = self.class.name.downcase

    define_singleton_method (base_method_name+"_keys").to_sym do |array=[]|
      1
      # RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).each {|cb| array << I18n.t(cb.name) }; array
    end 

    define_singleton_method (base_method_name+"_cb_name").to_sym do
      base_method_name
      # RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).each {|cb| array << I18n.t(cb.name) }; array
    end      

    define_singleton_method (base_method_name+"_values").to_sym do
      2
      # RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).map(&:value)
    end      

    define_singleton_method (base_method_name+"_cb_all").to_sym do
      3
      # RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).map(&:value)
    end      

    define_singleton_method (base_method_name+"_cb_object").to_sym do
      4
      # RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).map(&:value)
    end      

  end

end