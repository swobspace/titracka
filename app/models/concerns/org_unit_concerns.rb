module OrgUnitConcerns
  extend ActiveSupport::Concern
  NBSP = "\xC2\xA0"
  SUBTREE = "\xe2\x94\x94"
  ARROW = [8594].pack('U*')

  included do
    scope :active,  -> { where('(valid_until >= :date or valid_until is NULL)', date: Date.today) }

    def self.arrange_as_array(options={}, hash=nil)
      hash ||= arrange(options)
      arr = []
      hash.each do |node, children|
        arr << node
        arr += arrange_as_array(options, children) unless children.empty?
      end
      arr
    end
  end

  def name_for_selects
    "#{NBSP * depth * 2}#{SUBTREE unless depth == 0}#{name}"
  end
end
