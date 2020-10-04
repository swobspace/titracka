class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /states
  def index
    @states = State.all
    respond_with(@states)
  end

  # GET /states/1
  def show
    respond_with(@state)
  end

  # GET /states/new
  def new
    @state = State.new
    respond_with(@state)
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  def create
    @state = State.new(state_params)

    @state.save
    respond_with(@state)
  end

  # PATCH/PUT /states/1
  def update
    @state.update(state_params)
    respond_with(@state)
  end

  # DELETE /states/1
  def destroy
    @state.destroy
    respond_with(@state)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def state_params
      params.require(:state).permit(:name, :state)
    end
end
