class Workdays::TimeAccountingsController < TimeAccountingsController
  before_action :set_time_accountable

  def new
    @time_accounting = @time_accountable.time_accountings.new(date: accounting_date, task_id: params[:task_id])
    respond_with(@time_accounting)
  end

private
  def accounting_date
    @time_accountable.date
  end


  def set_time_accountable
    @time_accountable = Workday.find(params[:workday_id])
  end
end
