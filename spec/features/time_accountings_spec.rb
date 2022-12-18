require 'rails_helper'

RSpec.describe "TimeAccoutings", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit root_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit root_path
      execute_script("$.support.transition = false")
    end

    it "create a new time accounting via button" do
      click_link("Aktivitäten")
      find('a.dropdown-item[href="/time_accountings"]').click()
      sleep 1
      click_link("Aktivität erstellen")
      within "#modal-body" do
        within "div.time_accounting_task" do
          select "Mustermann GmbH / MM task", from: "time_accounting_task_id"
        end
        sleep 0.5
        fill_in "Beschreibung", with: "finishing test phrase"
        fill_in "Dauer (HH:MM)", with: "1:30"
        # save_and_open_screenshot()
        click_button "Aktivität erstellen"
      end
      sleep 1
      expect(page).to have_content("MM task")
      expect(page).to have_content("finishing test phrase")
      # hidden
      # expect(page).to have_content("Mustermann, Carola (mcaro)")
      expect(page).to have_content("01:30")
      # hidden
      # expect(page).to have_content("90")
      # save_and_open_screenshot()
    end
  end

  describe "visit time_accountings_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit time_accountings_path
      execute_script("$.support.transition = false")
    end

    it "create a new time accounting via menu" do
      find("a#navbarTimeAccountingsDropdown").click()
      find('a.dropdown-item[href="/time_accountings/new"]').click()
      sleep 1
      within "#modal-body" do
        within "div.time_accounting_task" do
          select "Mustermann GmbH / MM task", from: "time_accounting_task_id"
        end
        sleep 0.5
        fill_in "Beschreibung", with: "finishing test phrase"
        fill_in "Dauer (HH:MM)", with: "1:30"
        click_button "Aktivität erstellen"
      end
      sleep 1
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
      execute_script("$.support.transition = false")
    end

    it "delete a time_accounting" do
      expect(page).to have_content "Showing 1 to 1 of 1 entries"
      expect(TimeAccounting.count).to eq(1)
      within "tr#time_accounting_#{ta.id}" do
        accept_confirm do
          find('a[title="Aktivität löschen"]').click
        end
      end
      sleep 1
      expect(TimeAccounting.count).to eq(0)
      expect(page).to have_content "Showing 0 to 0 of 0 entries"
      # save_and_open_screenshot()
    end

    it "edit an existing time accounting" do
      within "tr#time_accounting_#{ta.id}" do
        find('a[title="Aktivität bearbeiten"]').click
      end
      sleep 1
      within "#modal-body" do
        fill_in "Beschreibung", with: "starting next phrase"
        fill_in "Dauer (HH:MM)", with: "1:20"
      end
      click_button("Aktivität aktualisieren")
      sleep 1
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
      expect(page).to have_content("Mustermann, Carola (mcaro)")
      # save_and_open_screenshot()
    end
  end
end

