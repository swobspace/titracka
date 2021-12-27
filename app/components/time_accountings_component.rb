# frozen_string_literal: true

class TimeAccountingsComponent < ViewComponent::Base
  def initialize(time_accountable:, user:)
    @time_accountable = time_accountable
    @user = user
  end

  def call
    if @time_accountable.kind_of? Task
      render Task::TimeAccountingsComponent.new(task: @time_accountable)
    elsif @time_accounable.kind_of? Workday
      render Workday::TimeAccountingsComponent.new(workday: @time_accountable, user: @user)
    else
      render TimeAccountings::IndexComponent.new(user: @user)
    end
  end

end
