require 'rails_helper'

RSpec.describe "day_types/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "day_types" }
    allow(controller).to receive(:action_name) { "edit" }

    @day_type = assign(:day_type, FactoryBot.create(:day_type))
  end

  it "renders the edit day_type form" do
    render

    assert_select "form[action=?][method=?]", day_type_path(@day_type), "post" do

      assert_select "input[name=?]", "day_type[abbrev]"

      assert_select "input[name=?]", "day_type[description]"
    end
  end
end
