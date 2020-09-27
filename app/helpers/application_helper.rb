module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def configuration_active_class
    if Titracka::CONFIGURATION_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end
end
