require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "notes" }
    allow(controller).to receive(:action_name) { "edit" }

    @noteable = FactoryBot.create(:task)
    @note = assign(:note, FactoryBot.create(:note))
  end

  it "renders the edit note form" do
    render

    assert_select "form[action=?][method=?]", task_note_path(@noteable, @note), "post" do
      assert_select "input[name=?]", "note[description]"
    end
  end
end
