class WorkdaysController < ApplicationController
  before_action :set_workday, only: [:show, :edit, :update, :destroy]
  # before_action :add_breadcrumb_show, only: [:show]

  # GET /workdays
  def index
    @workdays = @current_user.workdays
    respond_with(@workdays)
  end

  # GET /workdays/1
  def show
    add_breadcrumb(@workday.date.to_s, workday_path(@workday))
    @time_accountings = @current_user.time_accountings.where(date: @workday.date)
    @work_sum = @time_accountings.sum(:duration)
    @end_of_work = (@workday.work_start || @workday.date.to_time.beginning_of_day) + 
                     @work_sum.minutes + @workday.pause.minutes
    respond_with(@workday)
  end

  def by_date
    @workday = @current_user.workdays.where(date: params[:date]).first
    if @workday.nil?
      redirect_to new_workday_path(date: params[:date])
    else
      redirect_to workday_path(@workday)
    end
  end

  # GET /workdays/new
  def new
    @workday = @current_user.workdays.new(date: (params[:date] || Date.today.to_s))
    respond_with(@workday)
  end

  # GET /workdays/1/edit
  def edit
  end

  # POST /workdays
  def create
    @workday = @current_user.workdays.new(workday_params)

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
      @workday = @current_user.workdays.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workday_params
      params.require(:workday).permit(:date, :work_start, :pause)
    end
end
