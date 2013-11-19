class << ActiveRecord::Base

  # defining simple rules for codebook method generation
  #  class Project < ActiveRecord::Base
  #    has_codebooks({
  #      "status_cb"     => "boolean", // defining column_name => codebook_name
  #      "importance_cb" => "importance",
  #      "options" => {
  #        "status_cb" => {
  #          "fk_cb" => "id" // which value from codebook to use as FK for the model (usually id, value)
  #                          // can also be defined for each one codebook :)
  #        }
  #        "fk_cb" => "value" // all other will use this fallback or the default _value one :)
  #      }
  #    })
  #  end
  def has_codebooks params={}

    #  options given in model definition
    # "cb_format" => manually defined how to find codebook
    #  e.x. => polymorphic tables having role_cb row, but every time ...able_types is codebook, like this:
    #  class ProjectRelations < ActiveRecord::Base
    #    has_codebooks({
    #      "role_cb" => "polymorphic"             // says look to options, you are not going to find cb_name here :)
    #      "options" => {
    #        "role_cb" => {                       // in casse there are more codebooks that need these options
    #          "cb_format" => "projectable_type"  // will always be joined from cb_format+"_"+model.table_name+"_"+column_name.pluralized
    #        }
    #      }
    #    })
    #  end
    options = params["options"]
    params.delete("options")
    options["fk_cb"] = "value" unless options["fk_cb"]
    
    params.each do |column_name, codebook_name|

      # get the options just for the one codebook
      cb_options = options["#{column_name}"] || []
      fk_cb =  options["fk_cb"]
      
      base_method_name = column_name.gsub("_cb", "")

      unless cb_options.empty?
        codebook_name = cb_options["cb_format"]+"_"+self.table_name.singularize+"_"+base_method_name.pluralize if codebook_name == "polymorphic"
        fk_cb =  cb_options["fk_cb"]
      end


      # method for getting the one row referenced from model as object (something_object)
      define_method (base_method_name+"_object").to_sym do |hash={}|
        all = RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true)
        all.each {|row| return row if row.send(fk_cb) == self.send(column_name) }; hash
      end

      # method for getting the one row referenced from model as json (something)
      define_method (base_method_name+"_codebook_name").to_sym do
        codebook_name
      end  

      # method for getting the one row referenced from model as json (something)
      define_method base_method_name.to_sym do
        self.send(base_method_name+"_object").cb_serialize
      end    

      # method for getting all possible values of codebook or the column given (something_object_all) => OBJECT
      define_singleton_method (base_method_name+"_object_all").to_sym do
        RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true)
      end 

      # method for getting all possible values of codebook or the column given (something_object_all) => OBJECT
      define_singleton_method (base_method_name+"_collection").to_sym do
        RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).cb_serialize("collection_#{fk_cb}".to_sym)
      end    

      # method for getting all possible values of codebook or the column given (something_all) => JSON
      define_singleton_method (base_method_name+"_all").to_sym do
        RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).cb_serialize
      end    

      # method for getting the array of i18ned names of cb rows (something_names)
      define_singleton_method (base_method_name+"_names").to_sym do |array=[]|
        RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).each {|cb| array << I18n.t(cb.name) }; array
      end      

      # method for getting the array of values of cb rows (something_values)
      define_singleton_method (base_method_name+"_values").to_sym do
        RailsCodebook::Codebook.search(params[:page], "cb_name", codebook_name, true).map(&:value)
      end      

    end

  end

end