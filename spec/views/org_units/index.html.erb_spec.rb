require 'rails_helper'

RSpec.describe "org_units/index", type: :view do
  before(:each) do
    assign(:org_units, [
      OrgUnit.create!(
        name: "Name",
        ancestry: "Ancestry"
      ),
      OrgUnit.create!(
        name: "Name",
        ancestry: "Ancestry"
      )
    ])
  end

  it "renders a list of org_units" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Ancestry".to_s, count: 2
  end
end
