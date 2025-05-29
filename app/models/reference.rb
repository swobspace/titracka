class Reference < ApplicationRecord
  # -- associations
  has_many :cross_references, dependent: :restrict_with_error
  # has_many :reference_urls, dependent: :delete_all
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # accepts_nested_attributes_for :reference_urls, 
  #   allow_destroy: true,
  #   reject_if: proc {|attributes| attributes['name'].blank? || attributes['url'].blank?}


  def to_s
    "#{name}"
  end

  scope :active, -> { where('valid_until >= ? or valid_until IS NULL', Date.current) }

end
