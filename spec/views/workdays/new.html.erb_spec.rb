require 'rails_helper'

RSpec.describe "workdays/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "workdays" }
    allow(controller).to receive(:action_name) { "new" }

    @workday = assign(:workday, FactoryBot.build(:workday))

  end

  it "renders new workday form" do
    render

    assert_select "form[action=?][method=?]", workdays_path, "post" do
      assert_select "input[name=?]", "workday[date]"
      assert_select "input[name=?]", "workday[work_start]"
      assert_select "input[name=?]", "workday[pause]"
      assert_select "select[name=?]", "workday[day_type_id]"
      assert_select "input[name=?]", "workday[comment]"
    end
  end
end
