require 'rails_helper'

RSpec.describe "states/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "states" }
    allow(controller).to receive(:action_name) { "edit" }

    @state = assign(:state, FactoryBot.build(:state))
  end

  it "renders new state form" do
    render

    assert_select "form[action=?][method=?]", states_path, "post" do
      assert_select "input[name=?]", "state[name]"
      assert_select "select[name=?]", "state[state]"
    end
  end
end
