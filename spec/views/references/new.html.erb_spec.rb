require 'rails_helper'

RSpec.describe "references/new", type: :view do
  before(:each) do
    assign(:reference, Reference.new(
      name: "MyString",
      identifier_name: "MyString"
    ))
  end

  it "renders new reference form" do
    render

    assert_select "form[action=?][method=?]", references_path, "post" do

      assert_select "input[name=?]", "reference[name]"

      assert_select "input[name=?]", "reference[identifier_name]"
    end
  end
end
