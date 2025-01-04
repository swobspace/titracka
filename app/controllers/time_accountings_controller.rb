class TimeAccountingsController < ApplicationController
  before_action :set_time_accounting, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :set_tasks, only: [:new, :edit, :update, :create]

  # GET /time_accountings
  def index
    session[:time_accountings_mode] = :index
    if @time_accountable
      @time_accountings = @time_accountable.time_accountings
    else 
      @time_accountings = @current_user.time_accountings
    end
    respond_with(@time_accountings) do |format|
      format.json { render json: TimeAccountingsDatatable.new(@time_accountings, view_context) }
    end
  end

  def search_form
  end

  def search
    @time_accountings = @current_user.time_accountings.joins(:task)
    query = TimeAccountingQuery.new(@time_accountings, search_params)
    @time_accountings = query.all
    @filter_info = query.search_options
    respond_with(@time_accountings)
  end

  # GET /time_accountings/1
  def show
    session[:time_accountings_mode] = :show
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
    respond_with(@time_accounting, location: location) do |format|
      if @time_accounting.destroy && session[:mode] != 'time_accountings#show'
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
      if action_name == 'destroy'
        polymorphic_path(@time_accountable || :time_accountings)
      else
        polymorphic_path(@time_accountable || @time_accounting)
      end
    end

    def set_tasks
      @tasks = Task.accessible_by(current_ability, :read).includes(:org_unit, :list)
                   .order("org_units.name asc, lists.name asc, tasks.subject asc").decorate
    end
    def accounting_date
      Date.today
    end

   def search_params
        # see TimeAccountingQuery for possible options
        searchparms = params.permit(*submit_parms,
          :user_id, :user, :date, :newer, :older, :duration, 
          :description, :task,
          :id, :limit,
        ).to_hash 
      {limit: 100}.merge(searchparms).reject{|k, v| (v.blank? || submit_parms.include?(k))}     
    end
  
    def submit_parms
      [ "utf8", "authenticity_token", "commit", "format", "view" ]
    end

end
