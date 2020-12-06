require 'rails_helper'

RSpec.describe "org_units/show", type: :view do
  let!(:state) { FactoryBot.create(:state, :open) }
  before(:each) do
    @current_ability = Object.new
    @current_ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @current_ability }
    allow(controller).to receive(:controller_name) { "org_units" }
    allow(controller).to receive(:action_name) { "index" }

    parent = FactoryBot.create(:org_unit, name: "Parent Org")

    @org_unit = assign(:org_unit, OrgUnit.create!(
      name: "ACME Ltd.",
      parent_id: parent.id
    ))
    @columns = [state]
    @tasks_per_column = []
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ACME Ltd./)
  end
end
