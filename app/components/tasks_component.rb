# frozen_string_literal: true

class TasksComponent < ViewComponent::Base
  def initialize(tasks:, columns:, mode:, ability:)
    @tasks = tasks
    @columns = columns
    @mode = mode
    @ability = ability
  end

  def call
    if @mode == 'cards'
      Tasks::CardsComponent.new(tasks: @tasks, columns: @columns, ability: @ability)
                           .render_in(view_context)
    else
      raise RuntimeError, "ERROR:: TasksComponent mode /#{mode}/ not yet implemented"
    end
  end

end
