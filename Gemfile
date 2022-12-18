source 'https://rubygems.org'

gem 'rails', '~> 7.0.4'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.1'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rails-i18n', '~> 7.0.0'
gem 'sprockets-rails'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-yarn'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'libnotify'
  # gem 'railroady'
  # gem 'rails-plantuml-generator', git: 'https://github.com/HappyKadaver/rails-plantuml-generator'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'dotenv'
  gem 'guard-rspec', require: false
  gem 'byebug'

  gem 'json_spec', require: false
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdriver'
  gem 'launchy'
  gem 'timecop'
end

group :production do
  gem 'mysql2'
end

gem 'simple_form'
gem 'devise-remote-user'
gem 'paper_trail'
gem 'cancancan'
gem 'wobapphelpers', git: 'https://github.com/swobspace/wobapphelpers', branch: 'master'
gem 'wobauth', git: 'https://github.com/swobspace/wobauth.git', branch: 'master'
gem 'wobaduser', '~> 1.0'

gem 'acts_as_list'
gem 'ancestry'
gem 'asciidoctor'
gem 'js-routes'
gem 'yaml_db'
gem 'pagy'
gem 'draper'

gem 'rails-controller-testing'
gem 'exception_notification'

gem "redis", ">= 5.0"
gem "hiredis-client"
gem "prawn"
gem "prawn-markup"

gem "jsbundling-rails", "~> 1.0"

gem "cssbundling-rails", "~> 1.0"

gem "turbo-rails", "~> 1.0"

gem "view_component", "~> 2.47"

gem 'responders', git: 'https://github.com/heartcombo/responders.git', branch: 'main'

# for deployment
gem "ed25519"
gem "bcrypt_pbkdf"

gem "mail", '< 2.8.0'
