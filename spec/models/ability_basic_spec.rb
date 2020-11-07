require 'rails_helper'
require "cancan/matchers"

configuration_models = 
  Titracka::CONFIGURATION_CONTROLLER.map{|c| c.singularize.camelize.constantize}

data_models = [ List, Task, TimeAccounting, Workday ]
navigation = [:lists, :tasks, :time_accountings, :configuration]

RSpec.describe "User", :type => :model do
  fixtures 'wobauth/roles'

  subject(:ability) { Ability.new(user) }

  context "not logged in" do
    let(:user) { nil }

    # -- readable, ...
    [ Home ].each do |model|
      it { is_expected.to be_able_to(:read, Home) }
    end

    # -- nor readable, not writeable
    navigation.each do |navi|
      it { is_expected.not_to be_able_to(:navigate, navi) }
    end
    it { is_expected.not_to be_able_to(:read_on, OrgUnit.new) }
    it { is_expected.not_to be_able_to(:work_on, OrgUnit.new) }

    ( data_models + configuration_models).each do |model|
      context "on model #{model}" do
        it { is_expected.not_to be_able_to(:read, model.new) }
        it { is_expected.not_to be_able_to(:create, model.new) }
        it { is_expected.not_to be_able_to(:update, model.new) }
        it { is_expected.not_to be_able_to(:destroy, model.new) }
        it { is_expected.not_to be_able_to(:manage, model.new) }
      end
    end
  end

  context "logged in without any role" do
    let(:user) { FactoryBot.create(:user) }

    # -- readable, ...
    [ Home ].each do |model|
      it { is_expected.to be_able_to(:read, Home) }
    end
    # -- nor readable, not writeable
    navigation.each do |navi|
      it { is_expected.not_to be_able_to(:navigate, navi) }
    end
    it { is_expected.not_to be_able_to(:read_on, OrgUnit.new) }
    it { is_expected.not_to be_able_to(:work_on, OrgUnit.new) }

    # -- nor readable, not writeable
    ( data_models + configuration_models).each do |model|
      context "on model #{model}" do
        it { is_expected.not_to be_able_to(:read, model.new) }
        it { is_expected.not_to be_able_to(:create, model.new) }
        it { is_expected.not_to be_able_to(:update, model.new) }
        it { is_expected.not_to be_able_to(:destroy, model.new) }
        it { is_expected.not_to be_able_to(:manage, model.new) }
      end
    end

  end
end
