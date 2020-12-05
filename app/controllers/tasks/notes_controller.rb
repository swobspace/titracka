class Tasks::NotesController < NotesController
  before_action :set_noteable

private

  def set_noteable
    @noteable = Task.find(params[:task_id])
  end
end
