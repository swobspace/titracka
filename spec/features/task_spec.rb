require 'rails_helper'

RSpec.describe "Task", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit task_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit task_path(t2)
    end

    it "delete an existing task" do
      expect(page).to have_content "Caros task"
      expect(Task.count).to eq(10)
      accept_confirm do
        find('a[title="Aufgabe löschen"]').click
      end
      within "#ts_tasks" do
        expect(page).to have_content "Showing 1 to 6 of 6 entries"
      end
      expect(Task.count).to eq(9)
    end

    it "edit an existing task" do
      find('a[title="Aufgabe bearbeiten"]').click
      within "#modal" do
        find("trix-editor#task_description").set("a description for t2 task")
      end
      click_button("Aufgabe aktualisieren")
      within "#ts_show_task" do
        expect(page).to have_content("a description for t2 task")
      end
      # save_and_open_screenshot()
    end

    it "add a note" do
      click_link "Notiz erstellen"
      within "#modal" do
        find("trix-editor#note_description").set("yesterday it was so easy")
      end
      click_button("Notiz erstellen")
      within "#ts_notes_list" do
        expect(page).to have_content("yesterday it was so easy")
      end
      # save_and_open_screenshot()
    end

    it "add a time_accounting" do
      click_link "Aktivität erstellen"
      within "#modal" do
        fill_in "Beschreibung", with: "something we have done"
        fill_in "Dauer (HH:MM)", with: "1:30"
        click_button "Aktivität erstellen"
      end
      within "#ts_time_accountings" do
        expect(page).to have_content("something we have done")
      end
      # save_and_open_screenshot()
    end
  end
end

