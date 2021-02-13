require 'rails_helper'

RSpec.describe "day_types/new", type: :view do
  before(:each) do
    assign(:day_type, DayType.new(
      abbrev: "MyString",
      description: "MyString"
    ))
  end

  it "renders new day_type form" do
    render

    assert_select "form[action=?][method=?]", day_types_path, "post" do

      assert_select "input[name=?]", "day_type[abbrev]"

      assert_select "input[name=?]", "day_type[description]"
    end
  end
end
