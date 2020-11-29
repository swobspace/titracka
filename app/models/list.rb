class List < ApplicationRecord
  include ListConcerns
  # -- associations
  belongs_to :org_unit, optional: true
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  acts_as_list scope: [:org_unit_id]
  # -- validations and callbacks
  validates :name, :user_id, presence: true

  def to_s
    "#{name}"
  end

end
