require 'rails_helper'

RSpec.describe "workdays/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "workdays" }
    allow(controller).to receive(:action_name) { "index" }

    @current_user = FactoryBot.create(:user, sn: "Mustermann", 
                                      givenname: "Max", username: 'mmax')
    task = FactoryBot.create(:task, subject: "some task", user: @current_user)
    @time_accountings = FactoryBot.create_list(:time_accounting, 3,
                          date: 1.day.before(Date.today),
                          user: @current_user,
                          duration: 50,
                          task: task
                        )
    @time_accountings += FactoryBot.create_list(:time_accounting, 3,
                          date: 2.day.before(Date.today),
                          user: @current_user,
                          duration: 40,
                          task: task
                        )
    assign(:workdays, [
      Workday.create!(
        user: @current_user,
        date: 1.day.before(Date.today)
      ).decorate,
      Workday.create!(
        user: @current_user,
        date: 2.day.before(Date.today)
      ).decorate
    ])
  end

  it "renders a list of workdays" do
    render
    assert_select "tr>td", text: 1.day.before(Date.today).to_s, count: 1
    assert_select "tr>td", text: 2.day.before(Date.today).to_s, count: 1
    assert_select "tr>td", text: "02:00".to_s, count: 1
    assert_select "tr>td", text: "02:30".to_s, count: 1
  end
end
