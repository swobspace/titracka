require 'rails_helper'

RSpec.describe "references/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "references" }
    allow(controller).to receive(:action_name) { "show" }

    @reference = assign(:reference, Reference.create!(
      name: "DontDoIt",
      url: "https://ddi.none/local/###IDENTIFIER###/"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/DontDoIt/)
    expect(rendered).to match("https://ddi.none/local/###IDENTIFIER###/")
  end
end
