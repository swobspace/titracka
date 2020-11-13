if Rails.env.production? and Titracka.use_ssl
  Rails.application.config.force_ssl = true
end
