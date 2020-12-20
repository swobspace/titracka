class TaskDecorator < Draper::Decorator
  delegate_all
  ARROW = [8594].pack('U*')

  def name_with_list_or_org_unit
    [object.org_unit, object.list, object.subject].compact.map(&:to_s).join(" / ")
  end

  def phase
    # listed, starting needs start.present?
    if object.start.present? and object.start < Date.today
      if object.start < 10.days.before(Date.today)
        "listed"
      elsif object.start.present? and object.start >= 10.days.before(Date.today) 
        "starting"
      end
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
