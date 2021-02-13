require 'rails_helper'

RSpec.describe "day_types/show", type: :view do
  before(:each) do
    @day_type = assign(:day_type, DayType.create!(
      abbrev: "Abbrev",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Abbrev/)
    expect(rendered).to match(/Description/)
  end
end
