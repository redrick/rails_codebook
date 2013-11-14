module RailsCodebook

  module Controller
    
    class Base < ActionController::Base

      private

        def codebook
          "RailsCodebook::#{controller_name.classify}".constantize
        end

        def codebook_params
          params.require(controller_name.singularize.to_sym).permit(:name,:value,:codebook_name)
        end
    end
  
  end
end