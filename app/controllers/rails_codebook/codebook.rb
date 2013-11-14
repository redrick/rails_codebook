module RailsCodebook

  class CodebooksController < RailsCodebook::Controller::Base
    respond_to :json

    def show
      @codebook = codebook.find(params[:id])
      respond_with @codebook
    end

    def destroy
      @codebook = codebook.find(params[:id])
      @codebook.destroy
      respond_with true
    end

    def update
      @codebook = codebook.update(params[:id], codebook_params)
      respond_with @codebook.save
    end

    def create
      @codebook = codebook.create(codebook_params)
      respond_with @codebook.save
    end

    def new
      @codebook = codebook.new
      respond_with @codebook
    end

    def edit
      show
    end

    def search
      @codebook = codebook.search(codebook_params).results.paginate(page: params[:page])
      respond_with @codebook
    end

    def index
        binding.pry
      
      if params[:q]
        @codebook = codebook.search(params[:q]).paginate(page: params[:page])
        respond_with @codebook
      else        
        @codebook = codebook.all_codebookify.paginate(page: params[:page])
        respond_with @codebook
      end
    end

    def show
      @codebook = codebook.codebookify(params[:id])
      respond_with @codebook
    end

    # def model_attributes codebook
    #   { name: 'ad', value:'das', codebook_name:'sad'}
    # end

  end

end