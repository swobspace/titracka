require 'rails_helper'

RSpec.describe "TimeAccoutings", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit root_path
    end

    it "create a new time accounting via button" do
      click_link("Aktivitäten")
      find('a.dropdown-item[href="/time_accountings"]').click()
      click_link("Aktivität erstellen")
      within "#modal" do
        within "div.time_accounting_task" do
          select "Mustermann GmbH / MM task", from: "time_accounting_task_id"
        end
        fill_in "Beschreibung", with: "finishing test phrase"
        fill_in "Dauer (HH:MM)", with: "1:30"
        click_button "Aktivität erstellen"
      end
      expect(page).to have_content("MM task")
      expect(page).to have_content("finishing test phrase")
      expect(page).to have_content("01:30")
    end
  end

  describe "visit time_accountings_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit time_accountings_path
    end

    it "create a new time accounting via menu" do
      find("a#navbarTimeAccountingsDropdown").click()
      find('a.dropdown-item[href="/time_accountings/new"]').click()
      within "#modal" do
        within "div.time_accounting_task" do
          select "Mustermann GmbH / MM task", from: "time_accounting_task_id"
        end
        fill_in "Beschreibung", with: "finishing test phrase"
        fill_in "Dauer (HH:MM)", with: "1:30"
        click_button "Aktivität erstellen"
      end
      expect(page).to have_content("MM task")
      expect(page).to have_content("finishing test phrase")
      expect(page).to have_content("01:30")
    end
  end

  describe "visit time_accountings_path" do
    let!(:ta) do
      FactoryBot.create(:time_accounting, 
        task: t2, 
        user: mcaro,
        description: "preset time accounting for mcaro",
        duration: 66
      )
    end
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit time_accountings_path
      expect(page).to have_content("Aktivitäten")
    end

    it "delete a time_accounting" do
      expect(page).to have_content "Showing 1 to 3 of 3 entries"
      expect(TimeAccounting.count).to eq(6)
      within "tr#time_accounting_#{ta.id}" do
        accept_confirm do
          find('a[title="Aktivität löschen"]').click
        end
      end
      expect(page).to have_content "Showing 1 to 2 of 2 entries"
      expect(TimeAccounting.count).to eq(5)
      # save_and_open_screenshot()
    end

    it "edit an existing time accounting" do
      within "tr#time_accounting_#{ta.id}" do
        find('a[title="Aktivität bearbeiten"]').click
      end
      within "#modal" do
        fill_in "Beschreibung", with: "starting next phrase"
        fill_in "Dauer (HH:MM)", with: "1:20"
      end
      click_button("Aktivität aktualisieren")
      within "#ts_time_accountings" do
        expect(page).to have_content("starting next phrase")
        expect(page).to have_content("1:20")
      end
      # save_and_open_screenshot()
    end

    it "show an existing task" do
      within "tr#time_accounting_#{ta.id}" do
        find('a[title="Aktivität anzeigen"]').click
      end
      expect(page).to have_content("Caros task")
      expect(page).to have_content("preset time accounting for mcaro")
      expect(page).to have_content("1:06")
      # save_and_open_screenshot()
      expect(page).to have_content("Mustermann, Carola (mcaro)")
    end
  end
end

