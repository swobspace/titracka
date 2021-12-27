# frozen_string_literal: true

class Task::TimeAccountingsComponent < ViewComponent::Base
  def initialize(task:)
    @task = task
  end

end
