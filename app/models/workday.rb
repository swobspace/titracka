class Workday < ApplicationRecord
  # -- associations
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'
  has_many :time_accountings, ->(wday) { where("user_id = ?", wday.user_id) },
           foreign_key: :date, primary_key: :date

  # -- configuration
  # -- validations and callbacks
  validates :user_id, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id }

  def to_s
    "#{date.to_s}"
  end

end
