require 'rails_helper'

RSpec.describe "references/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "references" }
    allow(controller).to receive(:action_name) { "new" }

    @reference = assign(:reference, FactoryBot.build(:reference))
  end

  it "renders new reference form" do
    render

    assert_select "form[action=?][method=?]", references_path, "post" do
      assert_select "input[name=?]", "reference[name]"
      assert_select "input[name=?]", "reference[url]"
    end
  end
end
