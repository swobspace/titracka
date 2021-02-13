class DayTypesController < ApplicationController
  before_action :set_day_type, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /day_types
  def index
    @day_types = DayType.all
    respond_with(@day_types)
  end

  # GET /day_types/1
  def show
    respond_with(@day_type)
  end

  # GET /day_types/new
  def new
    @day_type = DayType.new
    respond_with(@day_type)
  end

  # GET /day_types/1/edit
  def edit
  end

  # POST /day_types
  def create
    @day_type = DayType.new(day_type_params)

    @day_type.save
    respond_with(@day_type)
  end

  # PATCH/PUT /day_types/1
  def update
    @day_type.update(day_type_params)
    respond_with(@day_type)
  end

  # DELETE /day_types/1
  def destroy
    @day_type.destroy
    respond_with(@day_type)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_type
      @day_type = DayType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def day_type_params
      params.require(:day_type).permit(:abbrev, :description)
    end
end
