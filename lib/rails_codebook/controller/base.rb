module RailsCodebook

  module Controller
    
    class Base < ActionController::Base
      before_filter :set_locale

      self.abstract_class = true

      def set_locale
          I18n.locale = params[:lang] || I18n.default_locale
      end

      private

        def codebook
          "RailsCodebook::#{controller_name.classify}".constantize
        end

        def codebook_params
          params.require(controller_name.singularize.to_sym).permit(:name,:value,:cb_name)
        end
    end
  
  end
end