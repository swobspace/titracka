require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        task: nil,
        user: nil
      ),
      Note.create!(
        task: nil,
        user: nil
      )
    ])
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
