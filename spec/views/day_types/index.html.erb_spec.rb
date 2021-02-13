require 'rails_helper'

RSpec.describe "day_types/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "day_types" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:day_types, [
      DayType.create!(
        abbrev: "KF",
        description: "Krank"
      ),
      DayType.create!(
        abbrev: "SI",
        description: "Sickness"
      )
    ])
  end

  it "renders a list of day_types" do
    render
    assert_select "tr>td", text: "KF".to_s, count: 1
    assert_select "tr>td", text: "SI".to_s, count: 1
    assert_select "tr>td", text: "Krank".to_s, count: 1
    assert_select "tr>td", text: "Sickness".to_s, count: 1
  end
end
