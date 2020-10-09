require 'rails_helper'

RSpec.describe "org_units/show", type: :view do
  before(:each) do
    @org_unit = assign(:org_unit, OrgUnit.create!(
      name: "Name",
      ancestry: "Ancestry"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Ancestry/)
  end
end
