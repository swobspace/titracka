# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def show
    @task = Task.find(element.dataset[:id].to_i)
    morph "#showTaskModalTable", TasksController.render(
      partial: 'tasks/show_task', locals: { task: @task }
    )
  end

  def new
    @task = Task.new
    morph "#taskModalForm", TasksController.render(
      partial: 'tasks/modal_form', locals: { task: @task }
    )
  end

end
