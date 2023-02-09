module WorkdaysHelper
  def start_of_day(workday, date = Date.today.to_s, target = '_self')
    if workday.nil?
      link_to "00:00", new_workday_path(:date => date)
    else
      if workday.work_start.nil?
        msg = "00:00"
      else
        msg = workday.work_start.to_fs(:hourmin)
      end
      link_to msg, edit_workday_path(workday), :target => target
    end
  end
end
