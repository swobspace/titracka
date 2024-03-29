class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :set_org_units, only: [:new, :edit, :update, :create]

  # GET /lists
  def index
    respond_with(@lists)
  end

  # GET /lists/1
  def show
    session[:tasks_filter] = session[:new_task_params] = { list_id: @list.id }
    session[:tasks_mode] = :cards
    @columns = State.visible
    @tasks   = @list.tasks.accessible_by(current_ability, :read)
    respond_with(@list)
  end

  # GET /lists/new
  def new
    @list = List.new
    respond_with(@list)
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  def create
    @list = @current_user.lists.new(list_params)

    @list.save
    respond_with(@list)
  end

  # PATCH/PUT /lists/1
  def update
    @list.update(list_params)
    respond_with(@list)
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    respond_with(@list)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:org_unit_id, :name, :description, :valid_until)
    end

    def set_org_units
      @org_units = OrgUnit.where(id: current_ability.rights.manager.org_units)
    end
end
