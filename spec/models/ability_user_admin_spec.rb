require 'rails_helper'
require "cancan/matchers"

configuration_models = 
  Titracka::CONFIGURATION_CONTROLLER.map{|c| c.singularize.camelize.constantize}

data_models = [ OrgUnit, List, Task, TimeAccounting, Workday ]
navigation = [:lists, :tasks, :time_accountings]

admin_models = [ Wobauth::User, Wobauth::Group, Wobauth::Authority, Wobauth::Membership, Wobauth::Role ]

RSpec.shared_examples "an UserAdmin with application Ability" do
  (configuration_models).each do |model|
    context "on model #{model}" do
      it { is_expected.not_to be_able_to(:manage, model.new) }
    end
  end
  # it { is_expected.to be_able_to(:read, AdUser.new) }

  # -- readable, ...
  [ Home ].each do |model|
    it { is_expected.to be_able_to(:read, Home) }
  end

  navigation.each do |navi|
    it { is_expected.not_to be_able_to(:navigate, navi) }
  end
  it { is_expected.to be_able_to(:navigate, :configuration) }
  it { is_expected.to be_able_to(:navigate, :org_units) }
  it { is_expected.to be_able_to(:navigate, Wobauth::User) }

  # -- nor readable, not writeable
  (data_models).each do |model|
    context "on model #{model}" do
      it { is_expected.not_to be_able_to(:read, model.new) }
      it { is_expected.not_to be_able_to(:create, model.new) }
      it { is_expected.not_to be_able_to(:update, model.new) }
      it { is_expected.not_to be_able_to(:destroy, model.new) }
      it { is_expected.not_to be_able_to(:manage, model.new) }
    end
  end
end

RSpec.shared_examples "an UserAdmin with Wobauth::AdminAbility" do
  it { is_expected.to be_able_to(:navigate, :configuration) }
  
  # -- readable, buth not writeable
  (admin_models).each do |model|
    context "on model #{model}" do
      it { is_expected.to be_able_to(:read, model.new) }
      it { is_expected.to be_able_to(:create, model.new) }
      it { is_expected.to be_able_to(:update, model.new) }
      it { is_expected.to be_able_to(:destroy, model.new) }
      it { is_expected.to be_able_to(:manage, model.new) }
    end
  end
end

RSpec.describe "User", :type => :model do
  fixtures 'wobauth/roles'

  describe "with ability assigned to user" do
    let(:user) { FactoryBot.create(:user) }
    let!(:authority) { 
      FactoryBot.create(:authority, 
	authorizable: user, 
	role: wobauth_roles(:user_admin))
    }
    context "on Ability" do
      subject(:ability) { Ability.new(user) }
      it_behaves_like "an UserAdmin with application Ability"
    end

    context "on Wobauth::AdminAbility" do
      subject(:ability) { Wobauth::AdminAbility.new(user) }
      it_behaves_like "an UserAdmin with Wobauth::AdminAbility"
    end
  end

  describe "with ability assigned to group" do
    let(:user) { FactoryBot.create(:user) }
    let(:group) { FactoryBot.create(:group) }
    let!(:membership) { FactoryBot.create(:membership, user: user, group: group) }
    let!(:authority) { 
      FactoryBot.create(:authority, 
	authorizable: group, 
	role: wobauth_roles(:user_admin))
    }
    context "on Ability" do
      subject(:ability) { Ability.new(user) }
      it_behaves_like "an UserAdmin with application Ability"
    end

    context "on Wobauth::AdminAbility" do
      subject(:ability) { Wobauth::AdminAbility.new(user) }
      it_behaves_like "an UserAdmin with Wobauth::AdminAbility"
    end
  end
end
