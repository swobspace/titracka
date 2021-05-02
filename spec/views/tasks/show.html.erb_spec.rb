require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  let(:reference) { FactoryBot.create(:reference, name: "DontDoIt") }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "tasks" }
    allow(controller).to receive(:action_name) { "show" }

    open = FactoryBot.create(:state, :open, name: 'Open')
    @task = assign(:task, FactoryBot.create(:task, 
      state: open,
      subject: "Subject",
      priority: "low",
      responsible: nil,
      org_unit: nil,
      list: nil,
      private: false,
      cross_references_attributes: [
        reference_id: reference.id,
        identifier: "166375"
      ]
    ))
    @current_user = FactoryBot.create(:user, sn: "Mustermann", givenname: "Max")
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/niedrig/)
    expect(rendered).to match(/Open/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/DontDoIt#166375/)
  end
end
