class OrgUnits::TasksController < TasksController
  before_action :set_taskable

private

  def set_taskable
    @taskable = OrgUnit.find(params[:org_unit_id])
  end
end
