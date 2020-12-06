class TaskDecorator < Draper::Decorator
  delegate_all
  ARROW = [8594].pack('U*')

  def name_with_list_or_org_unit
    [object.org_unit, object.list, object.subject].compact.map(&:to_s).join(" / ")
  end

end
