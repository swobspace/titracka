require 'rails_helper'

RSpec.describe "workdays/show", type: :view do
  before(:each) do
    @workday = assign(:workday, Workday.create!(
      user: nil,
      pause: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
