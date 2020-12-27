class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :set_associations, only: [:index, :new, :edit, :update, :create]

  # GET /tasks
  def index
    if @taskable
      @tasks = @taskable.tasks.accessible_by(current_ability, :read)
    end
    if search_params.present?
      @tasks = TaskQuery.new(@tasks.joins(:state), search_params).all
    end
    if params[:view] == 'cards'
      @columns = State.not_archived
      @tasks_per_column = @tasks.group_by(&:state_id)
      render template: 'tasks/cards'
    else
      respond_with(@tasks)
    end
  end

  def search_form
  end

  # GET /tasks/1
  def show
    respond_with(@task)
  end

  # GET /tasks/new
  def new
    if @taskable
      @task = @taskable.tasks.new(priority: 'normal')
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
        format.js { head :created }
      else
        format.js { render json: @task.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_with(@task, location: location) do |format|
      if @task.update(task_params)
        format.js { head :ok }
      else
        format.js { render json: @task.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_with(@task, location: location)
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
          :_destroy, :id, :reference_id, :identifier
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
        :submission, :to_submission, :from_submission, :subtree,
        :subject, :user, :responsible, :status, :state, :priority, :private,
        :has_references, :limit, :search
      ).to_hash
      searchparms.reject{|k, v| (v.blank? || submit_parms.include?(k))}
    end

    def submit_parms
      [ "utf8", "authenticity_token", "commit", "format", "view" ]
    end
end
