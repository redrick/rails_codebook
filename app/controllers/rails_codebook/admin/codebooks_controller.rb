module RailsCodebook
  module Admin
    class CodebooksController < RailsCodebook::Base

      def index
        @codebooks = codebook.all

        respond_to do |format|
          format.html { 
            render @codebooks
          }
        end
      end

        # def create

        #   codebook.create(params[:key], params[:value], params[:locale])
        #   respond_to do |format|
        #     format.html{
        #       redirect_to redis_dictionary_root_path, :notice => "Added translations"
        #     }
        #   end

        # end

        # def destroy
        #   codebook.destroy(params[:id])
        #   respond_to do |format|
        #     format.js
        #     format.html{
        #       redirect_to redis_dictionary_root_path, :notice => "Key deleted"
        #     }
        #   end

        # end


      private

        # Never trust parameters from the scary internet, only allow the white list through.
        def codebook_params
          params.require(:codebook).permit(:name, :value, :cb_name, :sequence, :deleted)
        end
    end
  end

end