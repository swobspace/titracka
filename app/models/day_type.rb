class DayType < ApplicationRecord
  # -- associations
  has_many :workdays, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :abbrev, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{abbrev}"
  end

end
