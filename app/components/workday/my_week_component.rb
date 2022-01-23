# frozen_string_literal: true

class Workday::MyWeekComponent < ViewComponent::Base
  delegate :hourmin, to: :helpers
  def initialize(workday:, user:)
    @workday = workday
    @current_user = user
    @week_sum = @current_user.decorate.working_time(week: @workday.date)
  end
end
