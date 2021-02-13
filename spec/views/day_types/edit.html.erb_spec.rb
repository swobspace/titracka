require 'rails_helper'

RSpec.describe "day_types/edit", type: :view do
  before(:each) do
    @day_type = assign(:day_type, DayType.create!(
      abbrev: "MyString",
      description: "MyString"
    ))
  end

  it "renders the edit day_type form" do
    render

    assert_select "form[action=?][method=?]", day_type_path(@day_type), "post" do

      assert_select "input[name=?]", "day_type[abbrev]"

      assert_select "input[name=?]", "day_type[description]"
    end
  end
end
