class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :set_associations, only: [:index, :new, :edit, :update, :create]
  before_action :set_columns, only: [:index, :update, :create, :destroy]
  before_action :set_tasks, only: [:update, :create, :destroy]

  # GET /tasks
  def index
    if @taskable
      @tasks = @taskable.tasks.accessible_by(current_ability, :read)
    else
       @tasks = Task.accessible_by(current_ability, :read)
    end
    if search_params.present?
      @tasks = TaskQuery.new(@tasks.joins(:state), search_params).all
      session[:tasks_filter] = search_params
    else
      session[:tasks_filter] = {}
    end
    if params[:view] == 'cards'
      render template: 'tasks/cards'
    else
      respond_with(@tasks)
    end
  end

  def search_form
  end

  # GET /tasks/1
  def show
    respond_with(@task) do |format|
      format.pdf do
        # just for testing, no real world usage for now
        path = File.join(Rails.root, 'app', 'views', 'tasks', 'show_pdf.html.erb')
        template = File.open(path).read
        string = ERB.new(template).result(binding)
        Rails.logger.debug(string)
        pdf = Prawn::Document.new
        pdf.markup(string)
        send_data pdf.render, :filename => "Task.pdf",
                              :disposition => 'inline',
                              :type => 'application/pdf'
      end

    end
  end

  # GET /tasks/new
  def new
    if @taskable
      @task = @taskable.tasks.new(search_params.merge(priority: 'normal'))
    else
      @task = @current_user.tasks.new(priority: 'normal')
    end
    respond_with(@task)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_with(@task, location: location) do |format|
      if @task.save
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_with(@task, location: location) do |format|
      if @task.update(task_params)
        format.turbo_stream
        format.js { head :created }
      else
        format.js { render json: @task.errors.full_messages, status: :unprocessable_enti
ty }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    respond_with(@task, location: location) do |format|
      if @task.destroy
        format.turbo_stream
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(
        :subject, :start, :deadline, :resubmission, :priority, :user_id,
        :responsible_id, :org_unit_id, :state_id, :list_id, 
        :private, :description,
        cross_references_attributes: [
          :_destroy, :id, :reference_id, :identifier, :subject
        ]
      )
    end

    def set_associations
      @users = Wobauth::User.active.order("sn, givenname")
      @org_units = OrgUnit.accessible_by(current_ability, :work_on)
      @lists = List.accessible_by(current_ability, :read).order(:name)
    end

    def location
      polymorphic_path(@taskable || @task)
    end

    def search_params
      searchparms = params.permit(*submit_parms,
        :id, :list_id, :org_unit_id, :user_id, :responsible_id, :state_id,
        :start, :to_start, :from_start, :deadline, :to_deadline, :from_deadline,
        :resubmission, :to_resubmission, :from_resubmission, :subtree,
        :subject, :user, :responsible, :status, :state, :priority, :private,
        :has_references, :limit, :search, :cross_reference, :without_lists,
        priority_ids: [], state_ids: [],
      ).to_hash
      searchparms.reject{|k, v| (v.blank? || submit_parms.include?(k))}
    end

    def submit_parms
      [ "utf8", "authenticity_token", "commit", "format", "view" ]
    end

    def set_columns
      @columns = State.not_archived
    end

    def set_tasks
      if @taskable
        @tasks = @taskable.tasks.accessible_by(current_ability, :read)
      else
         @tasks = Task.accessible_by(current_ability, :read)
      end
      if session[:tasks_filter].present?
        @tasks = TaskQuery.new(@tasks.joins(:state), session[:tasks_filter]).all
      end
    end
end
