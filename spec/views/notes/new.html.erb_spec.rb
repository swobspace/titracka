require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "notes" }
    allow(controller).to receive(:action_name) { "new" }
    allow(controller).to receive(:current_user) { nil }

    @noteable = FactoryBot.create(:task)
    @note = assign(:note, FactoryBot.build(:note))
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", task_notes_path(@noteable), "post" do
      assert_select "input[name=?]", "note[description]"
    end
  end
end
