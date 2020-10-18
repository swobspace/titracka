require 'rails_helper'

RSpec.describe "lists/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "index" }

    org_unit = FactoryBot.create(:org_unit, name: "ACME")

    assign(:lists, [
      FactoryBot.create(:list,
        org_unit: org_unit,
        name: "Name"
      ),
      FactoryBot.create(:list,
        org_unit: org_unit,
        name: "Name"
      )
    ])
  end

  it "renders a list of lists" do
    render
    assert_select "tr>td", text: "ACME".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
