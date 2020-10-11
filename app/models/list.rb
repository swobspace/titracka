class List < ApplicationRecord
  # -- associations
  belongs_to :org_unit, optional: true
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :name, :user_id, presence: true

  def to_s
    "#{name}"
  end

end