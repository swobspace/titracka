class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /references
  def index
    @references = Reference.all
    respond_with(@references)
  end

  # GET /references/1
  def show
    respond_with(@reference)
  end

  # GET /references/new
  def new
    @reference = Reference.new
    respond_with(@reference)
  end

  # GET /references/1/edit
  def edit
  end

  # POST /references
  def create
    @reference = Reference.new(reference_params)

    @reference.save
    respond_with(@reference)
  end

  # PATCH/PUT /references/1
  def update
    @reference.update(reference_params)
    respond_with(@reference)
  end

  # DELETE /references/1
  def destroy
    @reference.destroy
    respond_with(@reference)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reference_params
      params.require(:reference).permit(
        :name, :identifier_name, reference_urls_attributes: [
          :_destroy, :id, :name, :url
        ]
      )
    end
end
