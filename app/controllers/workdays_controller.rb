class WorkdaysController < ApplicationController
  before_action :set_workday, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /workdays
  def index
    @workdays = Workday.all
    respond_with(@workdays)
  end

  # GET /workdays/1
  def show
    respond_with(@workday)
  end

  # GET /workdays/new
  def new
    @workday = Workday.new
    respond_with(@workday)
  end

  # GET /workdays/1/edit
  def edit
  end

  # POST /workdays
  def create
    @workday = Workday.new(workday_params)

    @workday.save
    respond_with(@workday)
  end

  # PATCH/PUT /workdays/1
  def update
    @workday.update(workday_params)
    respond_with(@workday)
  end

  # DELETE /workdays/1
  def destroy
    @workday.destroy
    respond_with(@workday)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workday
      @workday = Workday.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workday_params
      params.require(:workday).permit(:user_id, :date, :work_start, :pause)
    end
end
