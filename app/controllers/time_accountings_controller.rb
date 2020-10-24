class TimeAccountingsController < ApplicationController
  before_action :set_time_accounting, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :set_tasks, only: [:new, :edit, :update, :create]

  # GET /time_accountings
  def index
    if @time_accountable
      @time_accountings = @time_accountable.time_accountings
    end
    respond_with(@time_accountings)
  end

  # GET /time_accountings/1
  def show
    respond_with(@time_accounting)
  end

  # GET /time_accountings/new
  def new
    if @time_accountable
      @time_accounting = @time_accountable.time_accountings.new
    else
      @time_accounting = TimeAccounting.new(date: Date.today.to_s)
    end
    respond_with(@time_accounting)
  end

  # GET /time_accountings/1/edit
  def edit
  end

  # POST /time_accountings
  def create
    @time_accounting = @current_user.time_accountings.new(time_accounting_params)
    @time_accounting.save
    respond_with(@time_accounting, location: location)
  end

  # PATCH/PUT /time_accountings/1
  def update
    @time_accounting.update(time_accounting_params)
    respond_with(@time_accounting, location: location)
  end

  # DELETE /time_accountings/1
  def destroy
    @time_accounting.destroy
    respond_with(@time_accounting, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_accounting
      @time_accounting = TimeAccounting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_accounting_params
      params.require(:time_accounting).permit(:task_id, :description, :date, :duration, 
                                              :formatted_duration)
    end

    def location
      polymorphic_path(@time_accountable || @time_accounting)
    end

    def set_tasks
      @tasks = Task.accessible_by(current_ability, :read).order(:subject)
    end
end
