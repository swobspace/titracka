module Titracka
  CONFIGURATION_CONTROLLER = [
    "states", "references", "day_types"
  ]
  CONFIGFILE = File.join(Rails.root, 'config', 'titracka.yml')
  if File.readable? CONFIGFILE
    config = YAML.load_file(CONFIGFILE)
  end
  CONFIG = config || Hash.new

  def self.fetch_config(attribute, default_value)
    CONFIG[attribute.to_s].presence || default_value
  end
 
  def self.devise_modules
    if CONFIG['devise_modules'].present?
      CONFIG['devise_modules']
    else
      [ :database_authenticatable,
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
    fetch_config('mail_from', 'root')
  end

  def self.mail_to
    Array(fetch_config('mail_to', nil))
  end

  def self.mail_prefix
    fetch_config('mail_prefix', nil)
  end

  def self.use_ssl
    fetch_config('use_ssl', false)
  end

  def self.remote_user
    fetch_config('remote_user', 'REMOTE_USER')
  end

  def self.action_cable_allowed_request_origins
    fetch_config('action_cable_allowed_request_origins',
                 ['http://localhost', 'https://localhost'])
  end

  def self.host
    fetch_config('host', 'localhost')
  end

  def self.port
    fetch_config('port', nil)
  end

  def self.script_name
    fetch_config('script_name', '/')
  end

  def self.smtp_settings
    fetch_config('smtp_settings', nil)&.symbolize_keys
  end

  ActionMailer::Base.default_url_options = {
   host: self.host,
   port: self.port,
   script_name: self.script_name
  }
  Rails.application.routes.default_url_options[:host] = self.host
  Rails.application.routes.default_url_options[:port] = self.port
  Rails.application.routes.default_url_options[:script_name] = self.script_name

end
