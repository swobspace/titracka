class OrgUnit < ApplicationRecord
  # -- associations
  has_many :lists, dependent: :restrict_with_error
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :name, presence: true

  def to_s
    "#{name}"
  end

end
