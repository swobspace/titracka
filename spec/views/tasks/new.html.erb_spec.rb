require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "tasks" }
    allow(controller).to receive(:action_name) { "new" }

    @task = assign(:task, FactoryBot.build(:task, :open))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input[name=?]", "task[subject]"
      assert_select "input[name=?]", "task[description]"
      assert_select "select[name=?]", "task[priority]"
      assert_select "select[name=?]", "task[responsible_id]"
      assert_select "select[name=?]", "task[org_unit_id]"
      assert_select "select[name=?]", "task[state_id]"
      assert_select "select[name=?]", "task[list_id]"
      assert_select "input[name=?]", "task[private]"
    end
  end
end
