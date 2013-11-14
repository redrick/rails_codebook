module RailsCodebook

  module Controller
    
    class Base < ActionController::Base

      def show
        @codebook = resource.find(params[:id])
        respond_with @codebook
      end

      def destroy
        @codebook = resource.find(params[:id])
        @codebook.destroy
        respond_with true
      end

      def update
        @codebook = resource.update(params[:id], resource_params)
        respond_with @codebook.save
      end

      def create
        @codebook = resource.create(resource_params)
        respond_with @codebook.save
      end

      def new
        @codebook = resource.new
        respond_with @codebook
      end

      def edit
        show
      end

      def search
        @codebook = resource.search(resource_params).results.paginate(page: params[:page])
        respond_with @codebook
      end

      def index
        if params[:q]
          @codebook = resource.search(params[:q]).paginate(page: params[:page])
          respond_with @codebook
        else        
          @codebook = resource.all_codebookify.paginate(page: params[:page])
          respond_with @codebook
        end
      end

      def show
        @codebook = resource.codebookify(params[:id])
        respond_with @codebook
      end

      # def model_attributes resource
      #   { name: 'ad', value:'das', codebook_name:'sad'}
      # end

      private

        def resource
          "RailsCodebook::#{controller_name.classify}".constantize
        end

        def resource_params
          params.require(controller_name.singularize.to_sym).permit(:name,:value,:codebook_name)
        end
    end
  
  end
end