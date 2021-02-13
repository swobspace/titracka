require 'rails_helper'

RSpec.describe "day_types/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "day_types" }
    allow(controller).to receive(:action_name) { "show" }

    @day_type = assign(:day_type, DayType.create!(
      abbrev: "KF",
      description: "Krank"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/KF/)
    expect(rendered).to match(/Krank/)
  end
end
