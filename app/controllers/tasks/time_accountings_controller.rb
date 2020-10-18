class Tasks::TimeAccountingsController < TimeAccountingsController
  before_action :set_time_accountable

private

  def set_time_accountable
    @time_accountable = Task.find(params[:task_id])
  end
end
