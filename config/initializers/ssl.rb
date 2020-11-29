if Rails.env.production? and Titracka.use_ssl
  Rails.application.config.force_ssl = true
  Rails.application.routes.default_url_options[:protocol] = 'https'
end
