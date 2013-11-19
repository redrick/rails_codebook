module RailsCodebook
  module Api
    class CodebooksController < RailsCodebook::Controller::Base

      # index for all codebooks
      # /codebooks
      def index
        @codebooks = codebook.all.paginate(page: params[:page])
        if params[:q]
          search 
        else
          render json: @codebooks.cb_serialize(params[:format])
        end
      end

      # index showing only one codebook
      # /codebooks/cb_name
      def codebook_index
        @codebooks = RailsCodebook::Codebook.search(params[:page], 'cb_name', params[:cb_name], true)
        if params[:q]
          search
        else
          render json: @codebooks.cb_serialize(params[:format])
        end
      end

      # showing one codebook line
      # /codebooks/cb_name/value
      def show
        @codebook = codebook.find(params[:id])
        render json: @codebook.cb_serialize(params[:format])
      end

      # searching one of the codebooks
      # /codebooks?q=something
      # /codebooks/cb_name?q=something
      def search
        @codebooks = RailsCodebook::Codebook.search(params[:page], 'name', params[:q], false, @codebooks)
        render json: @codebooks.cb_serialize(params[:format])
      end
    end
  end

end