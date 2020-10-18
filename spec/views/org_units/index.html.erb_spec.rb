require 'rails_helper'

RSpec.describe "org_units/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "org_units" }
    allow(controller).to receive(:action_name) { "index" }

    parent = FactoryBot.create(:org_unit, name: "ACME")

    assign(:org_units, [
      OrgUnit.create!(
        name: "Name1",
        parent_id: parent.id
      ),
      OrgUnit.create!(
        name: "Name2",
        parent_id: parent.id
      )
    ])
  end

  it "renders a list of org_units" do
    render
    assert_select "tr>td", text: "Name1".to_s, count: 1
    assert_select "tr>td", text: "Name2".to_s, count: 1
    assert_select "tr>td", text: "ACME".to_s, count: 2
  end
end
