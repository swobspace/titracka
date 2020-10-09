class TimeAccountingsController < ApplicationController
  before_action :set_time_accounting, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /time_accountings
  def index
    @time_accountings = TimeAccounting.all
    respond_with(@time_accountings)
  end

  # GET /time_accountings/1
  def show
    respond_with(@time_accounting)
  end

  # GET /time_accountings/new
  def new
    @time_accounting = TimeAccounting.new
    respond_with(@time_accounting)
  end

  # GET /time_accountings/1/edit
  def edit
  end

  # POST /time_accountings
  def create
    @time_accounting = TimeAccounting.new(time_accounting_params)

    @time_accounting.save
    respond_with(@time_accounting)
  end

  # PATCH/PUT /time_accountings/1
  def update
    @time_accounting.update(time_accounting_params)
    respond_with(@time_accounting)
  end

  # DELETE /time_accountings/1
  def destroy
    @time_accounting.destroy
    respond_with(@time_accounting)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_accounting
      @time_accounting = TimeAccounting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_accounting_params
      params.require(:time_accounting).permit(:task_id, :user_id, :description, :date, :duration)
    end
end
