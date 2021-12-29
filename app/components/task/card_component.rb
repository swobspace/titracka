# frozen_string_literal: true

class Task::CardComponent < ViewComponent::Base
  with_collection_parameter :task

  def initialize(task:, ability:)
    @task = task
    @ability = ability
  end

end
