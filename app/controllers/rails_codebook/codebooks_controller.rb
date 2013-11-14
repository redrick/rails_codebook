module RailsCodebook

  class CodebooksController < RailsCodebook::Controller::Base
 
    # index for all codebooks
    # /codebooks
    def index
      if params[:q]
        search
      else
        @codebook = codebook.all.paginate(page: params[:page])
        render json: @codebook
      end
    end

    # index showing only one codebook
    # /codebooks/cb_name
    def codebook_index
      if params[:q]
        search
      else
        @codebook = codebook.find_all_by_cb_name(params[:cb_name])
        render json: @codebook
      end
    end

    # showing one codebook line
    # /codebooks/cb_name/value
    def show
      @codebook = codebook.find(params[:id])
      render json: @codebook
    end

    # searching all the codebooks
    # /codebooks?q=something
    def search
      @codebook = codebook.search(codebook_params).paginate(page: params[:page])
      render json: @codebook
    end

    # searching one of the codebooks
    # /codebooks?q=something
    # /codebooks/cb_name?q=something
    def search
      @codebook = codebook.search(params[:q]).paginate(page: params[:page])
      render json: @codebook
    end
      
  end

end