require 'rails_helper'

RSpec.describe "workdays/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "workdays" }
    allow(controller).to receive(:action_name) { "edit" }

    @workday = assign(:workday, FactoryBot.create(:workday))
  end

  it "renders the edit workday form" do
    render

    assert_select "form[action=?][method=?]", workday_path(@workday), "post" do
      assert_select "input[name=?]", "workday[date]"
      assert_select "input[name=?]", "workday[work_start]"
      assert_select "input[name=?]", "workday[pause]"
    end
  end
end
