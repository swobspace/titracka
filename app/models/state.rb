class State < ApplicationRecord
  # -- associations
  has_many :tasks, dependent: :restrict_with_error

  # -- configuration
  STATES = [ "pre", "open", "done", "archive" ]
  NOT_ARCHIVED = [ "pre", "open", "done" ]
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :state, inclusion: STATES, allow_blank: false

  scope :not_archived, -> { where(state: NOT_ARCHIVED) }

  def to_s
    "#{name}"
  end

end
