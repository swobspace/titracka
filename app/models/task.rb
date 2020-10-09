class Task < ApplicationRecord
  # -- associations
  belongs_to :responsible
  belongs_to :org_unit
  belongs_to :state
  belongs_to :list

  # -- configuration
  # -- validations and callbacks
  validates :subject, :state_id, presence: true

  def to_s
    "#{subject}"
  end

end
