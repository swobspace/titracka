require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "edit" }

    OrgUnit.create!(name: "ACME")
    @org_units = OrgUnit.all

    @list = assign(:list, FactoryBot.create(:list))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "select[name=?]", "list[org_unit_id]"
      assert_select "input[name=?]", "list[name]"
    end
  end
end
