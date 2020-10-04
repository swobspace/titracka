class Task < ApplicationRecord
  # -- associations
  belongs_to :state

  # -- configuration
  # -- validations and callbacks
  validates :subject, :state_id, presence: true

  def to_s
    "#{subject}"
  end
end
