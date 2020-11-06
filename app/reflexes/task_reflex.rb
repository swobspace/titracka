# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def show(task_id)
    @task = Task.find(task_id)
    morph "#showTaskModalTable", TasksController.render(
      partial: 'tasks/show_task', locals: { task: @task }
    )
  end

end
