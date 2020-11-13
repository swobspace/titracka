module Titracka
  CONFIGURATION_CONTROLLER = [
    "org_units", "states",
  ]
  CONFIGFILE = File.join(Rails.root, 'config', 'titracka.yml')
  if File.readable? CONFIGFILE
    config = YAML.load_file(CONFIGFILE)
  end
  CONFIG = config || Hash.new

  def self.devise_modules
    if CONFIG['devise_modules'].present?
      CONFIG['devise_modules']
    else
      [ :remote_user_authenticatable,
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :trackable
      ]
    end
  end

  def self.ldap_options
    if CONFIG['ldap_options'].present?
      ldapopts = CONFIG['ldap_options']
      if ldapopts.kind_of? Hash
        ldapopts = [ldapopts]
      end
      ldapopts.each do |opts|
        opts.symbolize_keys!
        opts.each do |k,v|
          opts[k] = opts[k].symbolize_keys if opts[k].kind_of? Hash
        end
      end
    else
      nil
    end
  end

  def self.mail_from
    if CONFIG['mail_from'].present?
      CONFIG['mail_from']
    else
      'root'
    end
  end

  def self.use_ssl
    if CONFIG['use_ssl'].present?
      CONFIG['use_ssl']
    else
      false
    end
  end

  def self.remote_user
    if CONFIG['remote_user'].present?
      CONFIG['remote_user']
    else
      "REMOTE_USER"
    end
  end

  def self.action_cable_allowed_request_origins
    if CONFIG['action_cable_allowed_request_origins'].present?
      Array(CONFIG['action_cable_allowed_request_origins'])
    else
      [ 'http://localhost', 'https://localhost' ]
    end
  end

end
