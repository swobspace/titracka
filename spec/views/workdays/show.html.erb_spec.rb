require 'rails_helper'

RSpec.describe "workdays/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "workdays" }
    allow(controller).to receive(:action_name) { "show" }
    allow(controller).to receive(:can?).with(any_args).and_return(true)
    @current_ability = @ability

    @current_user = FactoryBot.create(:user, sn: "Mustermann", 
                                      givenname: "Max", username: 'mmax')
    task = FactoryBot.create(:task, subject: "some task", user: @current_user)
    @time_accountings = FactoryBot.create_list(:time_accounting, 3,
                          date: Date.today.to_s,
                          user: @current_user,
                          duration: 50,
                          task: task
                        )
    @workday = assign(:workday, FactoryBot.create(:workday,
      user: @current_user,
      pause: 20,
      work_start: '7:40',
      date: Date.today.to_s
    ))
    @work_sum = @time_accountings.map{|x| x.duration}.sum
    @end_of_work = @workday.work_start + @work_sum.minutes + @workday.pause.minutes
    @tasks = Array(task)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Pause/)
    expect(rendered).to match(/00:20/)
    expect(rendered).to match(/07:40/)
    expect(rendered).to match(/#{Date.today.to_s}/)
    expect(rendered).to match(/02:30/)
    expect(rendered).to match(/10:30/)
  end
end
