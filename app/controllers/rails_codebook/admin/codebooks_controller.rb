module RailsCodebook
  module Admin
    class CodebooksController < RailsCodebook::Controller::Base
      layout 'rails_codebook/application'

      def index
        unless params[:cb_name].blank?
          @codebooks = codebook.find_all_by_cb_name(params[:cb_name]).to_a.paginate(:page => params[:page], :per_page => 15)
        else
          @codebooks = codebook.all.paginate(:page => params[:page], :per_page => 15)
        end

        unless params[:query].blank?
          @codebooks = (params[:query] == '*') ? \
            @codebooks.select{|j| I18n.t(j.name) =~ /^#{params[:query]}$/}.paginate(:page => params[:page], :per_page => 15) : \
            @codebooks.select{|j| I18n.t(j.name) =~ /#{params[:query]}/}.paginate(:page => params[:page], :per_page => 15)
        end

        respond_to do |format|
          format.html { 
            render 'index', layout: true
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