require 'rails_helper'

RSpec.describe "notes/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "notes" }
    allow(controller).to receive(:action_name) { "show" }

    user = FactoryBot.create(:user, sn: 'Mustermann', givenname: 'Max')
    noteable = FactoryBot.create(:task, subject: "Task subject")
    assign(:note, FactoryBot.create(:note,
      task: noteable,
      description: "Note description",
      date: '2020-03-02',
      user: user
    ))

  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Task subject/)
    expect(rendered).to match(/Note description/)
    expect(rendered).to match(/Mustermann, Max/)
    expect(rendered).to match(/2020-03-02/)
  end
end
