require 'rails_helper'

RSpec.describe "Tasks", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit root_path
    end

    it "create a new task via button" do
      click_link("Aufgaben")
      find('a.dropdown-item[href="/tasks"]').click()
      click_link("Aufgabe erstellen")
      within "#modal" do
        fill_in "Aufgabe", with: "Preparations for Anniversary"
        click_button("Aufgabe erstellen")
      end
      expect(page).to have_content "Preparations for Anniversary"
      expect(page).to have_content "Showing 1 to 8 of 8 entries"
      # save_and_open_screenshot()
    end
  end

  describe "visit tasks_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit tasks_path
    end

    it "create a new task via menu" do
      find("a#navbarTasksDropdown").click()
      find('a.dropdown-item[href="/tasks/new"]').click()
      within "#modal" do
        fill_in "Aufgabe", with: "Preparations for Anniversary"
        click_button("Aufgabe erstellen")
      end
      expect(page).to have_content "Preparations for Anniversary"
      expect(page).to have_content "Showing 1 to 8 of 8 entries"
      # save_and_open_screenshot()
    end

    it "delete an existing task" do
      expect(page).to have_content "Showing 1 to 7 of 7 entries"
      expect(Task.count).to eq(10)
      within "tr#task_#{to1.id}" do
        accept_confirm do
          find('a[title="Aufgabe löschen"]').click
        end
      end
      sleep 1
      expect(Task.count).to eq(9)
    end

    it "edit an existing task" do
      within "tr#task_#{to1.id}" do
        find('a[title="Aufgabe bearbeiten"]').click
      end
      within "#modal" do
        find("trix-editor#task_description").set("a description for to1 task")
      end
      click_button("Aufgabe aktualisieren")
      within "#ts_tasks" do
        expect(page).to have_content("a description for to1 task")
      end
      # save_and_open_screenshot()
    end
    it "show an existing task" do
      within "tr#task_#{to1.id}" do
        find('a[title="Aufgabe anzeigen"]').click
      end
      expect(page).to have_content("Aufgabe: ##{to1.id}")
      expect(page).to have_content("MM task")
      # save_and_open_screenshot()
    end
  end
end

