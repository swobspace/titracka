module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def configuration_active_class
    if Titracka::CONFIGURATION_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def hourmin(minutes)
    msg = ""
    return "" if minutes.nil?
    if minutes < 0
      minutes = minutes.abs
      msg = "-"
    end
    hours = minutes / 60
    minutes = minutes % 60
    msg += sprintf "%02d:%02d", hours, minutes
  end

end
