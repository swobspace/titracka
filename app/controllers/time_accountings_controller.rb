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
      @time_accounting = @time_accountable.time_accountings.new(date: accounting_date)
    else
      @time_accounting = TimeAccounting.new(date: accounting_date)
    end
    respond_with(@time_accounting)
  end

  # GET /time_accountings/1/edit
  def edit
  end

  # POST /time_accountings
  def create
    if @time_accountable
      @time_accounting = @time_accountable.time_accountings.new(time_accounting_params)
      @time_accounting.update(user_id: @current_user.id)
    else
      @time_accounting = @current_user.time_accountings.new(time_accounting_params)
    end
    respond_with(@time_accounting, location: location) do |format|
      if @time_accounting.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_accountings/1
  def update
    respond_with(@time_accounting, location: location) do |format|
      if @time_accounting.update(time_accounting_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_accountings/1
  def destroy
    @time_accounting.destroy
    respond_with(@time_accounting, location: location) do |format|
      if @time_accounting.destroy
        format.turbo_stream 
      end
    end
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
      @tasks = Task.accessible_by(current_ability, :read).includes(:org_unit, :list)
                   .order("org_units.name asc, lists.name asc, tasks.subject asc").decorate
    end
    def accounting_date
      Date.today
    end
end
