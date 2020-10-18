require 'rails_helper'

RSpec.describe "states/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "states" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:states, [
      State.create!(
        name: "Name1",
        state: "open"
      ),
      State.create!(
        name: "Name2",
        state: "done"
      )
    ])
  end

  it "renders a list of states" do
    render
    assert_select "tr>td", text: "Name1".to_s, count: 1
    assert_select "tr>td", text: "Name2".to_s, count: 1
    assert_select "tr>td", text: "offen".to_s, count: 1
    assert_select "tr>td", text: "erledigt".to_s, count: 1
  end
end
