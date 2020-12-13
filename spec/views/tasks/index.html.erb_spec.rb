require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  let(:reference) { FactoryBot.create(:reference, name: "DontDoIt") }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "tasks" }
    allow(controller).to receive(:action_name) { "index" }

    state = FactoryBot.create(:state, :open, name: 'Open')
    user  = FactoryBot.create(:user, sn: "Bombadil", givenname: "Tom", username: "tom")

    assign(:tasks, [
      FactoryBot.create(:task,
        subject: "Subject",
        priority: "low",
        responsible: user,
        org_unit: nil,
        state: state,
        list: nil,
        private: false, 
        cross_references_attributes: [
          reference_id: reference.id,
          identifier: "676274"
        ]
      ),
      FactoryBot.create(:task,
        subject: "Subject",
        priority: "high",
        responsible: user,
        org_unit: nil,
        state: state,
        list: nil,
        private: false,
        cross_references_attributes: [
          reference_id: reference.id,
          identifier: "456048"
        ]
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: "Subject".to_s, count: 2
    assert_select "tr>td", text: "hoch".to_s, count: 1
    assert_select "tr>td", text: "niedrig".to_s, count: 1
    assert_select "tr>td", text: "Bombadil, Tom (tom)".to_s, count: 2
    assert_select "tr>td", text: "Open".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "DontDoIt#676274".to_s, count: 1
    assert_select "tr>td", text: "DontDoIt#456048".to_s, count: 1
  end
end
