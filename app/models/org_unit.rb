class OrgUnit < ApplicationRecord
  include OrgUnitConcerns

  # -- associations
  has_many :lists, dependent: :restrict_with_error
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  has_ancestry orphan_strategy: :adopt
  acts_as_list scope: [:ancestry]
  has_rich_text :description

  # -- validations and callbacks
  validates :name, presence: true

  def to_s
    "#{name}"
  end

end
