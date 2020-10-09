require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      subject: "MyString",
      priority: "MyString",
      responsible: nil,
      org_unit: nil,
      state: nil,
      list: nil,
      private: false
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[subject]"

      assert_select "input[name=?]", "task[priority]"

      assert_select "input[name=?]", "task[responsible_id]"

      assert_select "input[name=?]", "task[org_unit_id]"

      assert_select "input[name=?]", "task[state_id]"

      assert_select "input[name=?]", "task[list_id]"

      assert_select "input[name=?]", "task[private]"
    end
  end
end
