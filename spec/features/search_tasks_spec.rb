require 'rails_helper'

RSpec.describe "Workday", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit search_form_tasks_path
      execute_script("$.support.transition = false")
    end

    it "find a task" do
      select "offen", from: "state_ids[]"
      select "Mustermann GmbH", from: "Organisationseinheit"
      choose "Liste"
      click_button "Suche Aufgaben"
      sleep 1
      # save_and_open_screenshot
      expect(page).to have_content("Showing 1 to 2 of 2 entries")
      expect(page).to have_content("MM task")
      expect(page).to have_content("MM global list task")
    end
  end
end
