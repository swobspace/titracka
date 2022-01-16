# frozen_string_literal: true

class Task::CardComponent < ViewComponent::Base
  with_collection_parameter :task

  def initialize(task:, ability:)
    @task = task
    @ability = ability
    @state_archive_id = State.where(state: 'archive').first&.id
  end

end
