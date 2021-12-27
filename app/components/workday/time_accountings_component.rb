# frozen_string_literal: true

class Workday::TimeAccountingsComponent < ViewComponent::Base
  delegate :new_link, :show_link, :edit_link, :delete_link, :hourmin, :start_of_day, to: :helpers

  def initialize(workday:, user:)
    @workday = workday
    @current_user = user
    @time_accountings = @workday.time_accountings
    @work_sum = @time_accountings.sum(:duration)
    @week_sum = @current_user.decorate.working_time(week: @workday.date)
    @end_of_work = (@workday.work_start || @workday.date.to_time.beginning_of_day) +
                    @work_sum.minutes + @workday.pause.minutes

  end

end
