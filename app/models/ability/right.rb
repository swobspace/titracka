class Ability::Right
  attr_accessor :all

  def initialize
    @org_units = []
    @all = false
  end

  def add_org_units=(arr)
    @org_units += Array(arr)
  end

  def org_units
    @org_units.compact.uniq
  end

  def any_rights?
    @org_units.any? || @all
  end
end
