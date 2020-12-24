require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "tasks" }
    allow(controller).to receive(:action_name) { "edit" }

    OrgUnit.create!(name: "ACME")
    @org_units = OrgUnit.all

    @task = assign(:task, FactoryBot.create(:task, :open))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "input[name=?]", "task[subject]"
      assert_select "input[name=?]", "task[description]"
      assert_select "select[name=?]", "task[priority]"
      assert_select "select[name=?]", "task[user_id]"
      assert_select "select[name=?]", "task[responsible_id]"
      assert_select "select[name=?]", "task[org_unit_id]"
      assert_select "select[name=?]", "task[state_id]"
      assert_select "select[name=?]", "task[list_id]"
      assert_select "input[name=?]", "task[private]"
    end
  end
end
