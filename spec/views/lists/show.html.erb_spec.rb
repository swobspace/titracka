require 'rails_helper'

RSpec.describe "lists/show", type: :view do
  fixtures 'wobauth/users', :states
  let!(:state) { states(:open) }
  let(:user) { wobauth_users(:mcaro) }
  before(:each) do
    @current_ability = Object.new
    @current_ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @current_ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "show" }
    org_unit = FactoryBot.create(:org_unit, name: "ACME")

    @list = assign(:list, FactoryBot.create(:list,
      org_unit: org_unit,
      name: "Name",
      description: "Some stuff and more",
      valid_until: '2099-12-21',
      user: user
    ))

    @columns = [state]
    @tasks_per_column = []
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ACME/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Some stuff and more/)
    expect(rendered).to match(/2099-12-21/)
    expect(rendered).to match(/Mustermann, Carola \(mcaro\)/)
  end
end
