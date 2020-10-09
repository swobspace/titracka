require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      subject: "MyString",
      priority: "MyString",
      responsible: nil,
      org_unit: nil,
      state: nil,
      list: nil,
      private: false
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

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
