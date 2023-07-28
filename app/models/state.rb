class State < ApplicationRecord
  # -- associations
  has_many :tasks, dependent: :restrict_with_error
  default_scope { order(:position) }

  # -- configuration
  acts_as_list
  STATES = [ "pre", "open", "pending", "done", "archive", "deferred" ]
  VISIBLE = [ "pre", "open", "pending", "done" ]
  OPEN = [ "open", "pending" ]
  ACTIVE = [ "pre", "open", "pending" ]
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :state, inclusion: STATES, allow_blank: false

  scope :visible, -> { where(state: VISIBLE) }
  scope :open, -> { where(state: OPEN) }
  scope :active, -> { where(state: ACTIVE) }

  def to_s
    "#{name}"
  end

  def active?
    State::ACTIVE.include?(self.state)
  end

end
