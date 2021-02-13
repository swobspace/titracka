require 'rails_helper'

RSpec.describe "day_types/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "day_types" }
    allow(controller).to receive(:action_name) { "new" }

    assign(:day_type, FactoryBot.build(:day_type))
  end

  it "renders new day_type form" do
    render

    assert_select "form[action=?][method=?]", day_types_path, "post" do

      assert_select "input[name=?]", "day_type[abbrev]"

      assert_select "input[name=?]", "day_type[description]"
    end
  end
end
