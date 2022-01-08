require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "notes" }
    allow(controller).to receive(:action_name) { "edit" }

    user = FactoryBot.create(:user, sn: 'Mustermann', givenname: 'Max')
    @noteable = FactoryBot.create(:task, subject: "Task subject")
    assign(:notes, FactoryBot.create_list(:note, 2, 
      task: @noteable,
      description: "Note description",
      date: '2020-03-02',
      user: user
    ))
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", text: "Task subject".to_s, count: 2
    assert_select "tr>td", text: "Note description".to_s, count: 2
    assert_select "tr>td", text: "Mustermann, Max".to_s, count: 2
    assert_select "tr>td", text: "2020-03-02".to_s, count: 2
  end
end
