require 'rails_helper'

RSpec.describe "references/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "references" }
    allow(controller).to receive(:action_name) { "show" }

    @reference = assign(:references, [
      Reference.create!(
        name: "DontDoIt",
        url: "https://ddi.none/local/###IDENTIFIER###/",
        valid_until: "2199-12-13"
      ),
      Reference.create!(
        name: "DontDoIt2",
        url: "https://ddi.none/local/###IDENTIFIER###/",
        valid_until: "2199-12-13"
      )
    ])
  end

  it "renders a list of references" do
    render
    assert_select "tr>td", text: "DontDoIt".to_s, count: 1
    assert_select "tr>td", text: "DontDoIt2".to_s, count: 1
    assert_select "tr>td", text: "https://ddi.none/local/###IDENTIFIER###/".to_s, count: 2
    assert_select "tr>td", text: "2199-12-13".to_s, count: 2
  end
end
