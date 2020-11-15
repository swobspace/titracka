class Task < ApplicationRecord
  include TaskConcerns
  # -- associations
  belongs_to :state
  belongs_to :user, optional: false, inverse_of: :tasks, class_name: 'Wobauth::User'
  belongs_to :responsible, optional: true, inverse_of: :responsibilities, class_name: 'Wobauth::User'
  belongs_to :org_unit, optional: true
  belongs_to :list, optional: true
  has_many :time_accountings, dependent: :restrict_with_error

  # -- configuration
  has_rich_text :description
  PRIORITIES = ["low", "normal", "high"]

  # -- validations and callbacks
  before_save :set_org_unit

  validates :subject, :state_id, :user_id, presence: true
  validates :priority, inclusion: PRIORITIES, allow_blank: false

  def to_s
    "#{subject}"
  end

  private

  def set_org_unit
    unless list_id.nil?
      self[:org_unit_id] = list.org_unit_id
    end
  end

end
