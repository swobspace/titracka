class OrgUnitsController < ApplicationController
  before_action :set_org_unit, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /org_units
  def index
    @org_units = OrgUnit.all
    respond_with(@org_units)
  end

  # GET /org_units/1
  def show
    respond_with(@org_unit)
  end

  # GET /org_units/new
  def new
    @org_unit = OrgUnit.new
    respond_with(@org_unit)
  end

  # GET /org_units/1/edit
  def edit
  end

  # POST /org_units
  def create
    @org_unit = OrgUnit.new(org_unit_params)

    @org_unit.save
    respond_with(@org_unit)
  end

  # PATCH/PUT /org_units/1
  def update
    @org_unit.update(org_unit_params)
    respond_with(@org_unit)
  end

  # DELETE /org_units/1
  def destroy
    @org_unit.destroy
    respond_with(@org_unit)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org_unit
      @org_unit = OrgUnit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_unit_params
      params.require(:org_unit).permit(:name, :parent_id )
    end
end
