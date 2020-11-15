class HomeController < ApplicationController
  def index
    @org_units = arrange_with_lists(OrgUnit.accessible_by(current_ability, :read).arrange)
  end

  private
  def arrange_with_lists(hash = {})
    hash.each do |node, children|
      next if node.kind_of? List
      node.lists.each do |list|
        hash[node][list] = {}
      end
      hash[node].merge(arrange_with_lists(children))
    end
    hash
  end
end
