module RailsCodebook
  module Admin
    class CodebooksController < RailsCodebook::Controller::Base
      respond_to :html, :js
      layout 'rails_codebook/application'

      def index
        unless params[:cb_name].blank?          
          @codebooks = RailsCodebook::Codebook.search(params[:page], 'cb_name', params[:cb_name], true)
        else
          @codebooks = RailsCodebook::Codebook.search(params[:page])
        end

        unless params[:query].blank?
          @codebooks = (params[:query] == '*') ? \
            @codebooks = RailsCodebook::Codebook.search(params[:page], 'name', params[:query], true, @codebooks) : \
            @codebooks = RailsCodebook::Codebook.search(params[:page], 'name', params[:query], false, @codebooks)
        end

        respond_to do |format|
          format.html { 
            render 'index', layout: true
          }
        end
      end

      def create
        unless params[:codebook][:id].blank?
          @codebook = RailsCodebook::Codebook.find(params[:codebook][:id])
          @codebook.update_attributes(params[:codebook])
        else
          @codebook = RailsCodebook::Codebook.create(params[:codebook])
        end

        respond_to do |format|
          format.js
          format.html{
            redirect_to admin_codebooks_path
          }
        end

      end

      def destroy
        codebook.find(params[:id]).destroy
        respond_to do |format|
          format.js
          format.html{
            redirect_to admin_codebooks_path
          }
        end

      end


      private

        # Never trust parameters from the scary internet, only allow the white list through.
        def codebook_params
          params.require(:codebook).permit(:name, :value, :cb_name, :sequence, :deleted)
        end
    end
  end

end