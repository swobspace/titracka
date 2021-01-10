class ApplicationMailer < ActionMailer::Base
  default from: Titracka.mail_from
  layout 'mailer'
end
