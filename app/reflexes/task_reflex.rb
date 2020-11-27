# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def show
    @task = Task.find(element.dataset[:id].to_i)
    morph "#showTaskModalTable", TasksController.render(
      partial: 'tasks/show_task', locals: { task: @task }
    )
  end

  def new
    state_id = element.dataset[:column_id].to_i
    @task = Task.new(state_id: state_id)
    morph "#taskModalForm", TasksController.render(
      partial: 'tasks/modal_form', locals: { task: @task }
    )
  end

  def edit
    @task = Task.find(element.dataset[:id].to_i)
    morph "#taskModalForm", TasksController.render(
      partial: 'tasks/modal_form', locals: { task: @task }
    )
  end

end
