# frozen_string_literal: true

class TimeAccountingsComponent < ViewComponent::Base
  def initialize(time_accountable:, user:)
    @time_accountable = time_accountable
    @user = user
  end

  def call
    if @time_accountable.kind_of? Task
      Task::TimeAccountingsComponent.new(task: @time_accountable).render_in(view_context)
    elsif @time_accountable.kind_of? Workday
      Workday::TimeAccountingsComponent.new(workday: @time_accountable, user: @user).render_in(view_context)
    else
      TimeAccountings::IndexComponent.new(user: @user).render_in(view_context)
    end
  end

end
