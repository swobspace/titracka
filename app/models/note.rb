class Note < ApplicationRecord
  # -- associations
  belongs_to :task, optional: false, inverse_of: :notes
  belongs_to :user, optional: false, inverse_of: :notes, class_name: 'Wobauth::User'

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :description, :task_id, :user_id, :date, presence: true

  def to_s
    "#{description.to_plain_text}"
  end

end
