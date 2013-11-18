module RailsCodebook

  module Controller
    
    class Base < ActionController::Base
      helper :all
      before_filter :set_locale

      # setting locale if found in url
      def set_locale
        I18n.locale = params[:lang] || I18n.default_locale
      end

      private

        # name of codebook model, still the same for now...
        def codebook
          "RailsCodebook::#{controller_name.classify}".constantize
        end

        def codebook_params
          params.require(controller_name.singularize.to_sym).permit(:name, :value, :cb_name, :sequence, :deleted, :updated_at, :created_at)
        end
    end
  
  end
end