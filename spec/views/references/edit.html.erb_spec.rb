require 'rails_helper'

RSpec.describe "references/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "references" }
    allow(controller).to receive(:action_name) { "edit" }


    @reference = assign(:reference, FactoryBot.create(:reference))
  end

  it "renders the edit reference form" do
    render

    assert_select "form[action=?][method=?]", reference_path(@reference), "post" do
      assert_select "input[name=?]", "reference[name]"
      assert_select "input[name=?]", "reference[url]"
      assert_select "input[name=?]", "reference[valid_until]"
    end
  end
end
