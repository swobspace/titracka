require 'rails_helper'

RSpec.describe "lists/show", type: :view do
  let!(:state) { FactoryBot.create(:state, :open) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "show" }
    org_unit = FactoryBot.create(:org_unit, name: "ACME")

    @list = assign(:list, FactoryBot.create(:list,
      org_unit: org_unit,
      name: "Name"
    ))

    @columns = [state]
    @tasks_per_column = []
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ACME/)
    expect(rendered).to match(/Name/)
  end
end
