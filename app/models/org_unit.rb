class OrgUnit < ApplicationRecord
  # -- associations
  has_many :lists, dependent: :restrict_with_error
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  has_ancestry orphan_strategy: :adopt
  acts_as_list scope: [:ancestry]

  # -- validations and callbacks
  validates :name, presence: true

  def to_s
    "#{name}"
  end

end
