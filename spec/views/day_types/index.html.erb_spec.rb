require 'rails_helper'

RSpec.describe "day_types/index", type: :view do
  before(:each) do
    assign(:day_types, [
      DayType.create!(
        abbrev: "Abbrev",
        description: "Description"
      ),
      DayType.create!(
        abbrev: "Abbrev",
        description: "Description"
      )
    ])
  end

  it "renders a list of day_types" do
    render
    assert_select "tr>td", text: "Abbrev".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
