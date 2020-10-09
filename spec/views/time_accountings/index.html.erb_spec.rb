require 'rails_helper'

RSpec.describe "time_accountings/index", type: :view do
  before(:each) do
    assign(:time_accountings, [
      TimeAccounting.create!(
        task: nil,
        user: nil,
        description: "MyText",
        duration: 2
      ),
      TimeAccounting.create!(
        task: nil,
        user: nil,
        description: "MyText",
        duration: 2
      )
    ])
  end

  it "renders a list of time_accountings" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
