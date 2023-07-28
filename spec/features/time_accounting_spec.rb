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
      expect(TimeAccounting.count).to eq(6)
      accept_confirm do
        find('a[title="Aktivität löschen"]').click
      end
      within "#ts_time_accountings" do
        expect(page).to have_content "Showing 1 to 2 of 2 entries"
      end
      expect(TimeAccounting.count).to eq(5)
    end

    it "edit an existing time_accounting" do
      expect(page).to have_content "Caros task"
      find('a[title="Aktivität bearbeiten"]').click
      sleep 1
      within "#modal" do
        find("#time_accounting_description").set("a description for ta")
      end
      click_button("Aktivität aktualisieren")
      sleep 1
      expect(page).to have_content("a description for ta")
    end

  end
end

