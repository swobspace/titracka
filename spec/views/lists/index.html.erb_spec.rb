require 'rails_helper'

RSpec.describe "lists/index", type: :view do
  fixtures 'wobauth/users'
  let(:user) { wobauth_users(:mcaro) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "index" }

    org_unit = FactoryBot.create(:org_unit, name: "ACME")

    assign(:lists, [
      FactoryBot.create(:list,
        org_unit: org_unit,
        name: "Name",
        valid_until: '2099-12-12',
        description: 'some explanations',
        user: user,
      ),
      FactoryBot.create(:list,
        org_unit: org_unit,
        name: "Name",
        description: 'some explanations',
        user: user,
      )
    ])
  end

  it "renders a list of lists" do
    render
    assert_select "tr>td", text: "ACME".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "2099-12-12".to_s, count: 1
    assert_select "tr>td", text: "some explanations".to_s, count: 2
    assert_select "tr>td", text: "Mustermann, Carola (mcaro)".to_s, count: 2
  end
end
