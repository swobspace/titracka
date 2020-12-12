class ReferenceUrl < ApplicationRecord
  # -- associations
  belongs_to :reference, optional: false

  # -- validations and callbacks
  validates :name, :url, presence: true

  def to_s
    "#{name} [#{url}]"
  end

end
