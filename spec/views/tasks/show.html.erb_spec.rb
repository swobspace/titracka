require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
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
      priority: "Priority",
      responsible: nil,
      org_unit: nil,
      list: nil,
      private: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Priority/)
    expect(rendered).to match(/Open/)
    expect(rendered).to match(/false/)
  end
end
