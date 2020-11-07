# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def show
    @task = Task.find(element.dataset[:id].to_i)
    morph "#showTaskModalTable", TasksController.render(
      partial: 'tasks/show_task', locals: { task: @task }
    )
  end

end
