class ListDecorator < Draper::Decorator
  delegate_all

  def depth
    (object.org_unit.present?) ? org_unit.depth + 1 : 0
  end

  def children
    []
  end

  def descendant_ids
    []
  end

  def position
    (object.org_unit.present?) ? object.position : 1000 + object.position
  end
end
