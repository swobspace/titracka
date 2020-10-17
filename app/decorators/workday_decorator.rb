class WorkdayDecorator < Draper::Decorator
  delegate_all

  def duration
    TimeAccountingQuery.new(TimeAccounting.all, {date: object.date, user_id: object.user_id}).all.sum(:duration)
  end
end
