require 'rails_helper'
require "cancan/matchers"

configuration_models = 
  Titracka::CONFIGURATION_CONTROLLER.map{|c| c.singularize.camelize.constantize}

data_models = [ List, Task, TimeAccounting, Workday ]

RSpec.describe "User", :type => :model do
  fixtures 'wobauth/roles'

  subject(:ability) { Ability.new(user) }

  context "with role Admin" do
    let(:user) { FactoryBot.create(:user) }
    let!(:authority) { 
      FactoryBot.create(:authority, 
	authorizable: user, 
	role: wobauth_roles(:admin))
      }
    ( data_models + configuration_models).each do |model|
      context "on model #{model}" do
        it { is_expected.to be_able_to(:manage, model.new) }
      end
    end
  end
end
