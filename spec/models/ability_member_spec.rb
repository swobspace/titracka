require 'rails_helper'
require "cancan/matchers"

configuration_models =
  Titracka::CONFIGURATION_CONTROLLER.map{|c| c.singularize.camelize.constantize}

data_models = [ List, Task, TimeAccounting, Workday ]
navigation = [:lists, :tasks, :time_accountings, :configuration]

RSpec.shared_examples "a Member" do
  # -- readable, not writable
  navigation.each do |navi|
    it { is_expected.to be_able_to(:navigate, navi) }
  end
  # it { is_expected.to be_able_to(:read, AdUser.new) }

  context "working with own org_units" do
    it { is_expected.not_to be_able_to(:read_on, ou_0) }
    it { is_expected.to be_able_to(:read_on, ou_1) }
    it { is_expected.to be_able_to(:read_on, ou_2) }
    it { is_expected.not_to be_able_to(:work_on, ou_0) }
    it { is_expected.to be_able_to(:work_on, ou_1) }
    it { is_expected.to be_able_to(:work_on, ou_2) }
  end
  context "working with foreign org_units" do
    it { is_expected.not_to be_able_to(:read_on, ou_x0) }
    it { is_expected.not_to be_able_to(:read_on, ou_x1) }
    it { is_expected.not_to be_able_to(:read_on, ou_x2) }
    it { is_expected.not_to be_able_to(:work_on, ou_x0) }
    it { is_expected.not_to be_able_to(:work_on, ou_x1) }
    it { is_expected.not_to be_able_to(:work_on, ou_x2) }
  end

  # 
  # common config models, createable and own editable
  #

  data_models.each do |model|
    context "with own common config model #{model}" do
      let(:owned) { model.new(user_id: @user.id) }
      it { is_expected.to be_able_to(:read, owned) }
      it { is_expected.to be_able_to(:update, owned) }
      it { is_expected.to be_able_to(:destroy, owned) }
      it { is_expected.to be_able_to(:manage, owned) }
    end
  end

  # 
  # centra config models, only readable
  #

  configuration_models.each do |model|
    context "on central config model #{model}" do
      it { is_expected.to be_able_to(:read, model.new) }
      it { is_expected.not_to be_able_to(:create, model.new) }
      it { is_expected.not_to be_able_to(:update, model.new) }
      it { is_expected.not_to be_able_to(:destroy, model.new) }
      it { is_expected.not_to be_able_to(:manage, model.new) }
    end
  end

  describe "Lists" do
    it { is_expected.to be_able_to(:create, List.new) }

    context "within own org_unit tree" do
      it { is_expected.not_to be_able_to(:read, list_0) }
      it { is_expected.not_to be_able_to(:update, list_0) }
      it { is_expected.not_to be_able_to(:destroy, list_0) }
      it { is_expected.not_to be_able_to(:manage, list_0) }

      it { is_expected.to be_able_to(:read, list_1) }
      it { is_expected.not_to be_able_to(:update, list_1) }
      it { is_expected.not_to be_able_to(:destroy, list_1) }
      it { is_expected.not_to be_able_to(:manage, list_1) }

      it { is_expected.to be_able_to(:read, list_2) }
      it { is_expected.not_to be_able_to(:update, list_2) }
      it { is_expected.not_to be_able_to(:destroy, list_2) }
      it { is_expected.not_to be_able_to(:manage, list_2) }
    end

    context "outside of own org_unit tree" do
      # cannot
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.not_to be_able_to(action, list_x0) }
        it { is_expected.not_to be_able_to(action, list_x1) }
        it { is_expected.not_to be_able_to(action, list_x2) }
      end
    end

    context "lists owned by user" do
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.to be_able_to(action, list_u0) }
        it { is_expected.to be_able_to(action, list_u1) }
        it { is_expected.to be_able_to(action, list_u2) }
        it { is_expected.to be_able_to(action, list_xu0) }
        it { is_expected.to be_able_to(action, list_xu1) }
        it { is_expected.to be_able_to(action, list_xu2) }
      end
    end
  end

  describe "Tasks" do
    it { is_expected.to be_able_to(:create, Task.new) }

    context "within own org_unit tree" do
      # cannot
      it { is_expected.not_to be_able_to(:read, task_o0) }
      # can
      it { is_expected.to be_able_to(:read, task_o1) }
      it { is_expected.to be_able_to(:read, task_o2) }
  
      #cannot
      [:update, :destroy, :manage].each do |action|
        it { is_expected.not_to be_able_to(action, task_o0) }
        it { is_expected.not_to be_able_to(action, task_o1) }
        it { is_expected.not_to be_able_to(action, task_o2) }
      end
    end

    context "outside of own org_unit tree" do
      # cannot
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.not_to be_able_to(action, task_x0) }
        it { is_expected.not_to be_able_to(action, task_x1) }
        it { is_expected.not_to be_able_to(action, task_x2) }
      end
    end

    context "tasks owned by user" do
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.to be_able_to(action, task_u0) }
        it { is_expected.to be_able_to(action, task_u1) }
        it { is_expected.to be_able_to(action, task_u2) }
      end
    end
  end

  describe "TimeAccountings" do
    it { is_expected.to be_able_to(:create, TimeAccounting.new) }

    context "within own org_unit tree" do
      # cannot
      [:read, :update, :destroy, :manage].each do |action|
        it { is_expected.not_to be_able_to(action, tac_o0) }
        it { is_expected.not_to be_able_to(action, tac_o1) }
        it { is_expected.not_to be_able_to(action, tac_o2) }
      end
    end

    context "tasks owned by user" do
      # can
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.to be_able_to(action, tac_u0) }
      end
    end
    context "tasks not owned by user" do
      # cannot
      [ :read, :update, :destroy, :manage ].each do |action|
        it { is_expected.not_to be_able_to(action, tac_xu0) }
      end
    end
  end

  describe "Workdays" do
    it { is_expected.to be_able_to(:create, Workday.new) }

    [:read, :update, :destroy, :manage].each do |action|
      it { is_expected.to be_able_to(action, wday_u0) }
      it { is_expected.not_to be_able_to(action, wday_xu0) }
    end
  end
end

RSpec.describe "User", :type => :model do
  fixtures 'wobauth/roles'
  include_context "basic variables"
  before(:each) do
    @user = myuser
  end

  subject(:ability) { Ability.new(@user) }

  describe "with role Member assigned to user" do
    let!(:authority) { 
      FactoryBot.create(:authority, 
	authorizable: @user, 
	role: wobauth_roles(:member),
        authorized_for: ou_1)
    }
    it_behaves_like "a Member", @user
  end

  describe "with role Member assigned to group" do
    let(:group) { FactoryBot.create(:group) }
    let!(:membership) { FactoryBot.create(:membership, user: @user, group: group) }
    let!(:authority) { 
      FactoryBot.create(:authority, 
	authorizable: group, 
	role: wobauth_roles(:member),
        authorized_for: ou_1)
    }
    it_behaves_like "a Member", @user
  end
end

