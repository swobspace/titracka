require 'rails_helper'

RSpec.describe "time_accountings/new", type: :view do
  before(:each) do
    assign(:time_accounting, TimeAccounting.new(
      task: nil,
      user: nil,
      description: "MyText",
      duration: 1
    ))
  end

  it "renders new time_accounting form" do
    render

    assert_select "form[action=?][method=?]", time_accountings_path, "post" do

      assert_select "input[name=?]", "time_accounting[task_id]"

      assert_select "input[name=?]", "time_accounting[user_id]"

      assert_select "textarea[name=?]", "time_accounting[description]"

      assert_select "input[name=?]", "time_accounting[duration]"
    end
  end
end
