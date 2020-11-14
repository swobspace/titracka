class HomeController < ApplicationController
  def index
    @org_units = OrgUnit.accessible_by(current_ability, :read).arrange
  end
end
