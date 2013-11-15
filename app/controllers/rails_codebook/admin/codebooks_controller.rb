module RailsCodebook
  module Admin
    class CodebooksController < RailsCodebook::Controller::Base
      before_action :set_codebook, only: [:show, :edit, :update, :destroy]

      # GET /codebooks
      # GET /codebooks.json
      def index
        @codebooks = codebook.all
        render @codebooks, layout: true
      end

      # GET /codebooks/1
      # GET /codebooks/1.json
      def show
      end

      # GET /codebooks/new
      def new
        @codebook = codebook.new
      end

      # GET /codebooks/1/edit
      def edit
      end

      # POST /codebooks
      # POST /codebooks.json
      def create
        @codebook = codebook.new(codebook_params)

        respond_to do |format|
          if @codebook.save
            format.html { redirect_to @codebook, notice: 'Codebook was successfully created.' }
            format.json { render action: 'show', status: :created, location: @codebook }
          else
            format.html { render action: 'new' }
            format.json { render json: @codebook.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /codebooks/1
      # PATCH/PUT /codebooks/1.json
      def update
        respond_to do |format|
          if @codebook.update(codebook_params)
            format.html { redirect_to @codebook, notice: 'Codebook was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @codebook.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /codebooks/1
      # DELETE /codebooks/1.json
      def destroy
        @codebook.destroy
        respond_to do |format|
          format.html { redirect_to admin_codebooks_url }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_codebook
          @codebook = codebook.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def codebook_params
          params.require(:codebook).permit(:name, :value, :cb_name, :sequence, :deleted)
        end
    end
  end

end