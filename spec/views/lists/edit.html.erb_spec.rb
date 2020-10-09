require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      org_unit: nil,
      name: "MyString"
    ))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "input[name=?]", "list[org_unit_id]"

      assert_select "input[name=?]", "list[name]"
    end
  end
end
