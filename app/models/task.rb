class Task < ApplicationRecord
  # -- associations
  belongs_to :state
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'
  belongs_to :responsible, optional: true, inverse_of: :responsibilities, class_name: 'Wobauth::User'
  belongs_to :org_unit, optional: true
  belongs_to :list, optional: true
  has_many :time_accountings, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :subject, :state_id, :user_id, :priority, presence: true

  def to_s
    "#{subject}"
  end

end
