class TaskDecorator < Draper::Decorator
  delegate_all

  def name_with_list_or_org_unit
    if object.org_unit.present? && object.list.present?
      "#{object.org_unit.to_s} / #{object.list.to_s} / #{object.subject}"
    elsif object.org_unit.present?
      "#{object.org_unit.to_s} / #{object.subject}"
    elsif object.list.present?
      "#{object.list.to_s} / #{object.subject}"
    else
      "#{object.subject}"
    end
  end

end
