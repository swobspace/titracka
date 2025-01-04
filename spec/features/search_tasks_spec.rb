require 'rails_helper'

RSpec.describe "Workday", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit search_form_tasks_path
    end

    it "find a task" do
      within 'div.state_ids' do
        select "offen", from: "state_ids"
      end
      within 'div.org_unit_id' do
        select "Mustermann GmbH", from: "org_unit_id"
      end
      choose "Liste"
      click_button "Suche Aufgaben"
      # save_and_open_screenshot
      expect(page).to have_content("Showing 1 to 2 of 2 entries")
      expect(page).to have_content("MM task")
      expect(page).to have_content("MM global list task")
    end
  end
end
