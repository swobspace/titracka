require 'rails_helper'

RSpec.describe "workdays/index", type: :view do
  fixtures 'wobauth/users'
  let(:homeoffice) { FactoryBot.create(:day_type, abbrev: "HO", description: "HomeOffice") }
  let(:day1) { '2022-07-28'}
  let(:day2) { '2022-07-29'}
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "workdays" }
    allow(controller).to receive(:action_name) { "index" }

    @current_user = wobauth_users(:mmax)
    task = FactoryBot.create(:task, subject: "some task", user: @current_user)
    @time_accountings = FactoryBot.create_list(:time_accounting, 3,
                          date: day1,
                          user: @current_user,
                          duration: 50,
                          task: task

                        )
    @time_accountings += FactoryBot.create_list(:time_accounting, 3,
                          date: day2,
                          user: @current_user,
                          duration: 40,
                          task: task
                        )
    assign(:workdays, [
      Workday.create!(
        user: @current_user,
        date: day1,
        pause: 42,
        day_type: homeoffice,
        comment: "Working from Home"
      ).decorate,
      Workday.create!(
        user: @current_user,
        date: day2,
        pause: 42,
        day_type: homeoffice,
        comment: "Working from Home"
      ).decorate
    ])
  end

  it "renders a list of workdays" do
    render
    assert_select "tr>td", text: day1, count: 1
    assert_select "tr>td", text: day2, count: 1
    assert_select "tr>td", text: day1.to_date.year.to_s, count: 2
    assert_select "tr>td", text: day1.to_date.cweek.to_s, count: 2
    assert_select "tr>td", text: "02:30".to_s, count: 1
    assert_select "tr>td", text: "02:00".to_s, count: 1
    assert_select "tr>td", text: "42".to_s, count: 2
    assert_select "tr>td", text: "HO".to_s, count: 2
  end
end
