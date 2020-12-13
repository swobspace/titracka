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
        identifier_name: "Ticketnumber",
        reference_urls_attributes: [
          name: "DDI/Web",
          url: "https://ddi.none/local/###IDENTIFIER###/"
        ]
      ),
      Reference.create!(
        name: "DontDoIt2",
        identifier_name: "Ticketnumber",
        reference_urls_attributes: [
          name: "DDI/Web",
          url: "https://ddi.none/local/###IDENTIFIER###/"
        ]
      )
    ])
  end

  it "renders a list of references" do
    render
    assert_select "tr>td", text: "DontDoIt".to_s, count: 1
    assert_select "tr>td", text: "DontDoIt2".to_s, count: 1
    assert_select "tr>td", text: "Ticketnumber".to_s, count: 2
    assert_select "tr>td", text: "DDI/Web [ https://ddi.none/local/###IDENTIFIER###/ ]".to_s, count: 2
  end
end
