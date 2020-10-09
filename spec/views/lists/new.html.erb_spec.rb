require 'rails_helper'

RSpec.describe "lists/new", type: :view do
  before(:each) do
    assign(:list, List.new(
      org_unit: nil,
      name: "MyString"
    ))
  end

  it "renders new list form" do
    render

    assert_select "form[action=?][method=?]", lists_path, "post" do

      assert_select "input[name=?]", "list[org_unit_id]"

      assert_select "input[name=?]", "list[name]"
    end
  end
end
