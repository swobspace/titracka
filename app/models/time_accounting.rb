require 'minute_string'
class TimeAccounting < ApplicationRecord
  # -- associations
  belongs_to :task
  belongs_to :user, optional: false, inverse_of: :time_accountings, class_name: 'Wobauth::User'

  # -- configuration
  # -- validations and callbacks
  validates :description, :date, :duration, :task_id, :user_id, presence: true

  def to_s
    "#{date.to_s} /#{duration}/ #{task.subject} : #{description}"
  end

  def formatted_duration
    @duration_string = ::MinuteString.min2hour(self.duration)
  end

  def formatted_duration=(text)
    self.duration = ::MinuteString.hour2min(text)
  end

end
