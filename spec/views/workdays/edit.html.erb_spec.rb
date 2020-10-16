require 'rails_helper'

RSpec.describe "workdays/edit", type: :view do
  before(:each) do
    @workday = assign(:workday, Workday.create!(
      user: nil,
      pause: 1
    ))
  end

  it "renders the edit workday form" do
    render

    assert_select "form[action=?][method=?]", workday_path(@workday), "post" do

      assert_select "input[name=?]", "workday[user_id]"

      assert_select "input[name=?]", "workday[pause]"
    end
  end
end
