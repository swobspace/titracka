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

    it "create a new task" do
      click_link("Aufgaben")
      find('a.dropdown-item[href="/tasks"]').click()
      sleep 1
      click_link("Aufgabe erstellen")
      within "#modal-body" do
        fill_in "Aufgabe", with: "Preparations for Anniversary"
        click_button("Aufgabe erstellen")
      end
      sleep 1
      expect(page).to have_content "Preparations for Anniversary"
      expect(page).to have_content "Showing 1 to 7 of 7 entries"
      # save_and_open_screenshot()
    end
  end

  describe "visit tasks_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit tasks_path
      execute_script("$.support.transition = false")
    end

    it "delete an existing task" do
      expect(page).to have_content "Showing 1 to 6 of 6 entries"
      expect(Task.count).to eq(8)
      within "tr#task_#{to1.id}" do
        accept_confirm do
          find('a[title="Aufgabe löschen"]').click
        end
      end
      sleep 1
      expect(Task.count).to eq(7)
    end

    it "edit an existing task" do
      within "tr#task_#{to1.id}" do
        find('a[title="Aufgabe bearbeiten"]').click
      end
      sleep 1
      within "#modal-body" do
        find("trix-editor#task_description").set("a description for to1 task")
      end
      click_button("Aufgabe aktualisieren")
      sleep 1
      within "#ts_tasks" do
        expect(page).to have_content("a description for to1 task")
      end
      # save_and_open_screenshot()
    end
  end
end

