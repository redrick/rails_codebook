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
    # self _all {{cb},{cb},{cb}}
    # _object Object
    # _object_all [Object,Object]
    # _this {cb}
    # _name "cb_name"
    #
    ##

    # default options
    options = {
      "method"  => (self.model_name.to_s.downcase+"_cb").to_s,
      "key"     => "id",
      "value"   => "name" 
    }

    # merge default params with given ones (given are beating those default of course)
    options = options.merge params

    define_method (options["method"]+"_object").to_sym do
      self.class.where(["id=?", self.id]).select("#{options["key"]}, #{options["value"]}")
    end      

    define_method (options["method"]+"_this").to_sym do
      self.class.find(self.id).codebookify
    end

    define_singleton_method (options["method"]+"_object_all").to_sym do
      cb_model.all.select("#{options["key"]}, #{options["value"]}")
    end

    # just giving back the codebook name you chose or default
    define_singleton_method (options["method"]+"_name").to_sym do
      options["method"]
    end  

    # getting of the array of 
    define_singleton_method (options["method"]+"_keys").to_sym do |array=[]|
      cb_model.all.each {|row| array <<  row.send(options["key"])}; array
    end 

    define_singleton_method (options["method"]+"_values").to_sym do |array=[]|
      cb_model.all.each {|row| array <<  row.send(options["value"])}; array
    end      

    define_singleton_method (options["method"]+"_all").to_sym do |array=[]|
      cb_model.all.each {|row| array <<  row.codebookify}; array
    end
  
    # will there ever be other formats ?
    define_method :codebookify do |format=:cb_format|
      self.send(format)
    end

    # default cb format -> JSON
    define_method :cb_format do
      {
        key: self.send(options["key"]),
        value: self.send(options["value"])
      }
    end

    private

      def cb_model
        self.model_name.to_s.constantize   
      end    


  end

end