require 'rails_helper'

RSpec.describe "time_accountings/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "time_accountings" }
    allow(controller).to receive(:action_name) { "index" }

    task = FactoryBot.create(:task, :open, subject: "A special task")
    user = FactoryBot.create(:user, sn: "Mustermann", givenname: "Max", username: "mmax")

    assign(:time_accountings, [
      FactoryBot.create(:time_accounting,
        task: task,
        user: user,
        date: "2020-02-27",
        description: "MyText",
        duration: 240
      ),
      FactoryBot.create(:time_accounting,
        task: task,
        user: user,
        date: "2020-02-27",
        description: "MyText",
        duration: 240
      )
    ])
  end

  it "renders a list of time_accountings" do
    render
    assert_select "tr>td", text: "2020-02-27".to_s, count: 2
    assert_select "tr>td", text: "Mustermann, Max (mmax)".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "A special task".to_s, count: 2
    assert_select "tr>td", text: 240.to_s, count: 2
  end
end
