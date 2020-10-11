if defined? Devise and Devise.secret_key.nil?
  if Rails.env.development? or Rails.env.test?
    Devise.secret_key = ('x' * 128)
  else
    Devise.secret_key = Rails.application.secrets.secret_key_base
  end
end
