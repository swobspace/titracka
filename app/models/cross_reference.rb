class CrossReference < ApplicationRecord
  # -- associations
  belongs_to :task, optional: false
  belongs_to :reference, optional: false
  # -- validations and callbacks
  validates :identifier, presence: true

  def to_s
    "#{reference.name}##{identifier}"
  end

end
