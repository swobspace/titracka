class States::TasksController < TasksController
  before_action :set_taskable

private

  def set_taskable
    @taskable = State.find(params[:state_id])
  end
end
