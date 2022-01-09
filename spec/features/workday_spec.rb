require 'rails_helper'

RSpec.describe "Workday", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit root_path
      execute_script("$.support.transition = false")
    end

    it "asks for new day params" do
      print page.html
      find("button.navbar-toggler").click()
      click_link("heute")
      sleep 1
      save_and_open_screenshot()
    end

  end
end

