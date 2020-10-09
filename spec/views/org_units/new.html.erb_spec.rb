require 'rails_helper'

RSpec.describe "org_units/new", type: :view do
  before(:each) do
    assign(:org_unit, OrgUnit.new(
      name: "MyString",
      ancestry: "MyString"
    ))
  end

  it "renders new org_unit form" do
    render

    assert_select "form[action=?][method=?]", org_units_path, "post" do

      assert_select "input[name=?]", "org_unit[name]"

      assert_select "input[name=?]", "org_unit[ancestry]"
    end
  end
end
