class Reference < ApplicationRecord
  # -- associations
  has_many :cross_references, dependent: :restrict_with_error
  has_many :reference_urls, dependent: :delete_all
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :identifier_name, presence: true

  def to_s
    "#{name} [#{identifier_name}]"
  end

end
