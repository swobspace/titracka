require 'rails_helper'

RSpec.describe "workdays/new", type: :view do
  before(:each) do
    assign(:workday, Workday.new(
      user: nil,
      pause: 1
    ))
  end

  it "renders new workday form" do
    render

    assert_select "form[action=?][method=?]", workdays_path, "post" do

      assert_select "input[name=?]", "workday[user_id]"

      assert_select "input[name=?]", "workday[pause]"
    end
  end
end
