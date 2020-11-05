# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def show(task_id)
    @task = Task.find(task_id)
  end

end
