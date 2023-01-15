class WorkdayDecorator < Draper::Decorator
  delegate_all

  def duration
    TimeAccountingQuery.new(TimeAccounting.all, {date: object.date, user_id: object.user_id}).all.sum(:duration)
  end

  def work_start_hourmin
    if object.work_start.nil?
      "00:00"
    else
      object.work_start.to_fs(:hourmin)
    end
  end
end
