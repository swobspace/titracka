require 'rails_helper'

RSpec.describe "org_units/edit", type: :view do
  before(:each) do
    @org_unit = assign(:org_unit, OrgUnit.create!(
      name: "MyString",
      ancestry: "MyString"
    ))
  end

  it "renders the edit org_unit form" do
    render

    assert_select "form[action=?][method=?]", org_unit_path(@org_unit), "post" do

      assert_select "input[name=?]", "org_unit[name]"

      assert_select "input[name=?]", "org_unit[ancestry]"
    end
  end
end
