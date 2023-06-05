require 'rails_helper'

RSpec.describe "time_accountings/show", type: :view do
  fixtures 'wobauth/users'
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "time_accountings" }
    allow(controller).to receive(:action_name) { "show" }

    task = FactoryBot.create(:task, :open, subject: "A special task")
    user = wobauth_users(:mmax)

    @time_accounting = assign(:time_accounting, TimeAccounting.create!(
      date: '2020-02-23',
      task: task,
      user: user,
      description: "MyText",
      duration: 23
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2020-02-23/)
    expect(rendered).to match(/A special task/)
    expect(rendered).to match(/Mustermann, Max \(mmax\)/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/23/)
  end
end
