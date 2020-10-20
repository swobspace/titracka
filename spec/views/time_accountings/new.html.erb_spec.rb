require 'rails_helper'

RSpec.describe "time_accountings/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "time_accountings" }
    allow(controller).to receive(:action_name) { "new" }

    @time_accounting = assign(:time_accounting, FactoryBot.build(:time_accounting))
  end

  it "renders new time_accounting form" do
    render

    assert_select "form[action=?][method=?]", time_accountings_path, "post" do
      assert_select "select[name=?]", "time_accounting[task_id]"
      assert_select "input[name=?]", "time_accounting[user_id]", count: 0
      assert_select "input[name=?]", "time_accounting[description]"
      assert_select "input[name=?]", "time_accounting[formatted_duration]"
    end
  end
end
