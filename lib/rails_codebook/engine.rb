module RailsCodebook
  class Engine < ::Rails::Engine
    isolate_namespace RailsCodebook


    def initialize_content
      routes = ['']
      if File.exists?(File.join(Gem.loaded_specs['rails_codebook'].full_gem_path, 'config', 'locales', 'cs.yml'))
        default_cb_route = [File.join(Gem.loaded_specs['rails_codebook'].full_gem_path, 'config', 'locales', 'cs.yml')]
        routes = RailsCodebook::configuration.cb_data_path + default_cb_route
      end

      routes.each do |filename|
        
        codebook_values_file = (File.exists?(filename)) ? filename : nil

        if codebook_values_file
          cb_config_root = JSON.parse(YAML::load(File.open(codebook_values_file)).to_json)

          cb_config_root.each do |root, root_values|
            root_values.each do |cb, cb_values|
              if cb == RailsCodebook::configuration.cb_key
                cb_values.each do |name, name_values|
                  name_values.each do |one_name, translation|
                    if RailsCodebook::Codebook.find(:all, :conditions => {name: "#{cb}.#{name}.#{one_name}" } ).empty?
                      RailsCodebook::Codebook.create(value: "#{one_name}", name: "#{cb}.#{name}.#{one_name}", cb_name: "#{name}")
                    end
                  end
                end
              end
            end
          end
        end

      end
    end

  end
end