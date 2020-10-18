require 'rails_helper'

RSpec.describe "org_units/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "org_units" }
    allow(controller).to receive(:action_name) { "edit" }

    @org_unit = assign(:org_unit, FactoryBot.create(:org_unit))
  end

  it "renders the edit org_unit form" do
    render

    assert_select "form[action=?][method=?]", org_unit_path(@org_unit), "post" do

      assert_select "input[name=?]", "org_unit[name]"
      assert_select "select[name=?]", "org_unit[parent_id]"
    end
  end
end
