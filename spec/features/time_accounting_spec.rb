require 'rails_helper'

RSpec.describe "TimeAccounting", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  describe "visit time_accounting_path" do
    let!(:ta) do
      FactoryBot.create(:time_accounting,
        task: t2,
        user: mcaro,
        description: "preset time accounting for mcaro",
        duration: 66,
        date: "2022-01-02"
      )
    end

    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit time_accounting_path(ta)
      execute_script("$.support.transition = false")
    end

    it "delete an existing time_accounting" do
      expect(page).to have_content "2022-01-02 /66/ Caros task : preset time accounting for mcaro"
      expect(page).to have_content "Caros task"
      expect(TimeAccounting.count).to eq(1)
      accept_confirm do
        find('a[title="Aktivität löschen"]').click
      end
      sleep 1
      expect(TimeAccounting.count).to eq(0)
      within "#ts_time_accountings" do
        expect(page).to have_content "Showing 0 to 0 of 0 entries"
      end
    end

    it "edit an existing time_accounting" do
      skip "for now"
      find('a[title="Aufgabe bearbeiten"]').click
      sleep 1
      within "#modal-body" do
        find("trix-editor#task_description").set("a description for t2 task")
      end
      click_button("Aufgabe aktualisieren")
      sleep 1
      within "#ts_show_time_accounting" do
        expect(page).to have_content("a description for t2 task")
      end
      # save_and_open_screenshot()
    end

  end
end

