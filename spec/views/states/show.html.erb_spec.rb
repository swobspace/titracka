require 'rails_helper'

RSpec.describe "states/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "states" }
    allow(controller).to receive(:action_name) { "show" }

    @state = assign(:state, State.create!(
      name: "Name",
      state: "open"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/offen/)
  end
end
