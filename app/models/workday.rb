class Workday < ApplicationRecord
  # -- associations
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'

  # -- configuration
  # -- validations and callbacks
  validates :date, :user_id, presence: true

  def to_s
    "#{date.to_s}"
  end

end
