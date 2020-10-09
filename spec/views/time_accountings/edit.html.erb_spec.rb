require 'rails_helper'

RSpec.describe "time_accountings/edit", type: :view do
  before(:each) do
    @time_accounting = assign(:time_accounting, TimeAccounting.create!(
      task: nil,
      user: nil,
      description: "MyText",
      duration: 1
    ))
  end

  it "renders the edit time_accounting form" do
    render

    assert_select "form[action=?][method=?]", time_accounting_path(@time_accounting), "post" do

      assert_select "input[name=?]", "time_accounting[task_id]"

      assert_select "input[name=?]", "time_accounting[user_id]"

      assert_select "textarea[name=?]", "time_accounting[description]"

      assert_select "input[name=?]", "time_accounting[duration]"
    end
  end
end
