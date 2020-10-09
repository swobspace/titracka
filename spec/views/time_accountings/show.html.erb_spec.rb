require 'rails_helper'

RSpec.describe "time_accountings/show", type: :view do
  before(:each) do
    @time_accounting = assign(:time_accounting, TimeAccounting.create!(
      task: nil,
      user: nil,
      description: "MyText",
      duration: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
