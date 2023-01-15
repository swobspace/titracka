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
      click_link("heute")
      fill_in "Tagesbeginn", with: "8:00"
      click_button "Arbeitstag erstellen"
      expect(page).to have_content(I18n.l(Date.today, format: '%A'))
      expect(page).to have_content("Woche")
    end
  end

  describe "with existing workday" do
    let!(:wday) { FactoryBot.create(:workday, date: Date.today, user: mcaro) }
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit by_date_path(date: Date.today.to_s)
      execute_script("$.support.transition = false")
    end

    it "add a new time accounting" do
      expect(page).to have_content("Aktivität erstellen")
      click_link "Aktivität erstellen"
      within "#modal-body" do
        within "div.time_accounting_task" do
          select "Mustermann GmbH / MM task", from: "time_accounting_task_id"
        end
        fill_in "Beschreibung", with: "was habe ich getan"
        fill_in "Dauer (HH:MM)", with: "1:30"
        click_button "Aktivität erstellen"
      end
      within "#ts_time_accountings" do
        expect(page).to have_content("MM task")
        expect(page).to have_content("was habe ich getan")
        expect(page).to have_content("Mustermann, Carola (mcaro)")
        expect(page).to have_content("[ 01:30 ]")
        expect(page).to have_content("90")
      end
      # save_and_open_screenshot()
    end

    it "edit an existing time_accounting" do
      ta = FactoryBot.create(:time_accounting, task: to1, user: mcaro, 
                              description: "Lorem Ipsum trallalla",
                              date: Date.today, duration: 125)
      visit by_date_path(date: Date.today.to_s)
      within "tr#time_accounting_#{ta.id}" do
        find('a[title="Aktivität bearbeiten"]').click()
      end
      within "#modal-body" do
        fill_in "Dauer (HH:MM)", with: "3:10"
        click_button "Aktivität aktualisieren"
      end
      within "#ts_time_accountings" do
        expect(page).to have_content("MM task")
        expect(page).to have_content("Lorem Ipsum trallalla")
        expect(page).to have_content("Mustermann, Carola (mcaro)")
        expect(page).to have_content("[ 03:10 ]")
        expect(page).to have_content("190")
      end
      # save_and_open_screenshot()
    end

    it "add time_accounting via recent task card" do
      ta = FactoryBot.create(:time_accounting, task: to1, user: mcaro, 
                              description: "Lorem Ipsum trallalla",
                              date: Date.today, duration: 125)
      visit by_date_path(date: Date.today.to_s)
      within "div#card_task_#{to1.id}" do
        find('a[title="Aktivität hinzufügen"]').click()
      end
      within "#modal-body" do
        fill_in "Beschreibung", with: "Aktivität via recent task card"
        fill_in "Dauer (HH:MM)", with: "1:20"
        click_button "Aktivität erstellen"
      end
      within "#ts_time_accountings" do
        expect(page).to have_content("MM task")
        expect(page).to have_content("Aktivität via recent task card")
        expect(page).to have_content("Mustermann, Carola (mcaro)")
        expect(page).to have_content("[ 03:25 ]")
        expect(page).to have_content("205")
      end
      # save_and_open_screenshot()
    end

    it "delete a time accounting" do
      ta = FactoryBot.create(:time_accounting, task: to1, user: mcaro, 
                              description: "Lorem Ipsum trallalla",
                              date: Date.today, duration: 125)
      visit by_date_path(date: Date.today.to_s)
      within "tr#time_accounting_#{ta.id}" do
        accept_confirm do
          find('a[title="Aktivität löschen"]').click()
        end
      end
      # save_and_open_screenshot()
      within "#ts_time_accountings" do
        expect(page).not_to have_content("MM task")
        expect(page).not_to have_content("Aktivität via recent task card")
        expect(page).not_to have_content("Mustermann, Carola (mcaro)")
        expect(page).to have_content("[ 00:00 ]")
      end
    end

    it "updates workday" do
      find('div.card div.card-header a[title="Arbeitstag bearbeiten"]').click()
      fill_in "Bemerkung", with: "some remarks"
      click_button "Arbeitstag aktualisieren"
      expect(page).to have_content(I18n.l(Date.today, format: '%A'))
      expect(page).to have_content("Woche")

      accept_confirm do
        find('div.card div.card-header a[title="Arbeitstag löschen"]').click()
      end
      expect(page).to have_content("Arbeitstag erfolgreich gelöscht")
    end

  end
end

