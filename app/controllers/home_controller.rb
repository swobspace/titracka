class HomeController < ApplicationController
  def index
    @elements = arrange_with_lists(OrgUnit.accessible_by(current_ability).arrange)
  end

  private
  def arrange_with_lists(hash = {})
    # add lists associated to org_unit
    hash.each do |node, children|
      next if node.kind_of? List
      node.lists.each do |list|
        hash[node][list.decorate] = {}
      end
      hash[node].merge(arrange_with_lists(children))
    end
    # add lists without assigned org_unit
    # List.accessible_by(current_ability).where(org_unit_id: nil).each do |list|
    #   hash.merge({list => {}})
    # end
    hash
  end
end
