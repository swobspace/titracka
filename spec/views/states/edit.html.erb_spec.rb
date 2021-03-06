require 'rails_helper'

RSpec.describe "states/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "states" }
    allow(controller).to receive(:action_name) { "edit" }

    @state = assign(:state, FactoryBot.create(:state))
  end

  it "renders the edit state form" do
    render

    assert_select "form[action=?][method=?]", state_path(@state), "post" do
      assert_select "input[name=?]", "state[name]"
      assert_select "select[name=?]", "state[state]"
      assert_select "input[name=?]", "state[position]"
    end
  end
end
