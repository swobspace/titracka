class State < ApplicationRecord
  # -- associations
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  STATES = [ "pre", "open", "pending", "done", "archive" ]
  NOT_ARCHIVED = [ "pre", "open", "pending", "done" ]
  OPEN = [ "open", "pending" ]
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :state, inclusion: STATES, allow_blank: false

  scope :not_archived, -> { where(state: NOT_ARCHIVED) }
  scope :open, -> { where(state: OPEN) }

  def to_s
    "#{name}"
  end

end
