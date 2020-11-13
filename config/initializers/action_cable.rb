if Rails.env.production? and Titracka.action_cable_allowed_request_origins
  config.action_cable.allowed_request_origins = Titracka.action_cable_allowed_request_origins
end
