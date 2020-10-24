require 'rails_helper'

RSpec.describe "lists/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "lists" }
    allow(controller).to receive(:action_name) { "new" }

    OrgUnit.create!(name: "ACME")
    @org_units = OrgUnit.all

    @list = assign(:list, FactoryBot.build(:list))
  end

  it "renders new list form" do
    render

    assert_select "form[action=?][method=?]", lists_path, "post" do

      assert_select "select[name=?]", "list[org_unit_id]"
      assert_select "input[name=?]", "list[name]"
    end
  end
end
