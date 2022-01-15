# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'shoulda/matchers'
require 'factory_bot_rails'
require 'capybara/rspec'

Capybara.register_driver :mychrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new 

  [ "headless", "window-size=1280x1024", "disable-gpu" ].each do |arg| 
    options.add_argument(arg)
  end

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Capybara.javascript_driver = :selenium_chrome
# Capybara.javascript_driver = :selenium_chrome_headless
Capybara.javascript_driver = :mychrome
Capybara.disable_animation = true

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # -- devise stuff
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :view
  config.include RequestMacros, type: :request
  config.include RequestMacros, type: :feature

  # config.before(:suite) do
  #   DatabaseRewinder.clean_all
  # end
  # config.after(:each) do
  #   DatabaseRewinder.clean
  # end
end
