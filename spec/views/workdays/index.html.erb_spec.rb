require 'rails_helper'

RSpec.describe "workdays/index", type: :view do
  before(:each) do
    assign(:workdays, [
      Workday.create!(
        user: nil,
        pause: 2
      ),
      Workday.create!(
        user: nil,
        pause: 2
      )
    ])
  end

  it "renders a list of workdays" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
