class HomeController < ApplicationController
  def index
    set_associations
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
    listhash = {}
    List.accessible_by(current_ability).where(org_unit_id: nil).each do |list|
      listhash.tap do |h|
        h[list.decorate] = {}
      end
    end
    Rails.logger.debug("DEBUG:: #{pp listhash}")
    hash.merge(listhash)
  end

  def set_associations
    @users = Wobauth::User.active.order("sn, givenname")
    @org_units = OrgUnit.where(id: current_ability.rights.manager.org_units)
    @lists = List.accessible_by(current_ability, :read).order(:name)
  end

end
