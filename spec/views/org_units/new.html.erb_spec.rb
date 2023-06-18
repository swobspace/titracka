require 'rails_helper'

RSpec.describe "org_units/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "org_units" }
    allow(controller).to receive(:action_name) { "new" }

    @org_unit = assign(:org_unit, FactoryBot.build(:org_unit))
  end

  it "renders new org_unit form" do
    render

    assert_select "form[action=?][method=?]", org_units_path, "post" do

      assert_select "input[name=?]", "org_unit[name]"
      assert_select "select[name=?]", "org_unit[parent_id]"
      assert_select "input[name=?]", "org_unit[description]"
      assert_select "input[name=?]", "org_unit[valid_until]"
    end
  end
end
