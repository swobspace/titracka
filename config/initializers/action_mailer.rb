if Rails.env.production? 
  if Titracka.smtp_settings.nil?
    ActionMailer::Base.delivery_method = :file
  else
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = Titracka.smtp_settings
  end
end
