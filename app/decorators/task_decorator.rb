class TaskDecorator < Draper::Decorator
  delegate_all
  ARROW = [8594].pack('U*')

  def name_with_list_or_org_unit
    [object.org_unit, object.list, object.subject].compact.map(&:to_s).join(" / ")
  end

  def phase
    # inactive
    return "inactive" unless object.state.active?
    # listed, starting needs start.present?
    if object.start.present? and object.start > Date.today
      if object.start > 10.days.after(Date.today)
        "listed"
      elsif object.start <= 10.days.after(Date.today) 
        "starting"
      end
    # overdue and landing needs deadline.present?
    elsif object.deadline.present?
      if object.deadline > 10.days.after(Date.today)
        "active"
      elsif object.deadline < Date.today
        "overdue"
      else
        "landing"
      end
    else
      "active"
    end
  end

end
