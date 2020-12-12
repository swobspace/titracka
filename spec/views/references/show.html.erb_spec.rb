require 'rails_helper'

RSpec.describe "references/show", type: :view do
  before(:each) do
    @reference = assign(:reference, Reference.create!(
      name: "Name",
      identifier_name: "Identifier Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Identifier Name/)
  end
end
