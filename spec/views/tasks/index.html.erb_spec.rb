require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        subject: "Subject",
        priority: "Priority",
        responsible: nil,
        org_unit: nil,
        state: nil,
        list: nil,
        private: false
      ),
      Task.create!(
        subject: "Subject",
        priority: "Priority",
        responsible: nil,
        org_unit: nil,
        state: nil,
        list: nil,
        private: false
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: "Subject".to_s, count: 2
    assert_select "tr>td", text: "Priority".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
