class Workdays::TimeAccountingsController < TimeAccountingsController
  before_action :set_time_accountable

private
  def accounting_date
    @time_accountable.date
  end


  def set_time_accountable
    @time_accountable = Workday.find(params[:workday_id])
  end
end
