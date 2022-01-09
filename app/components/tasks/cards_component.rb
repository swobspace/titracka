# frozen_string_literal: true

class Tasks::CardsComponent < ViewComponent::Base
  def initialize(tasks:, columns:, ability:)
    @tasks = Array(tasks)
    @columns = Array(columns)
    @ability = ability
    col = @columns.first

    unless columntype = col.class.name.to_s == 'State'
      raise RuntimeError, "ERROR:: Tasks::CardsComponent for #{columntype} not yet implemented"
    end

    if @tasks.any?
      grouper = "#{col.class.name.to_s.underscore}_id".to_sym
      @tasks_per_column = @tasks.group_by(&grouper)
    else
      @tasks_per_column = []
    end
  end

end
