module ListConcerns
  extend ActiveSupport::Concern

  included do
    scope :active,  -> { where('(valid_until >= :date or valid_until is NULL)', date: Date.today) }
  end

  def name_for_selects
    # "#{NBSP * depth * 2}#{SUBTREE unless depth == 0}#{name}"
    name.to_s
  end
end
