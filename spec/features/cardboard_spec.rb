require 'rails_helper'

RSpec.describe "Cardboard", type: :feature, js: true do
  fixtures 'wobauth/roles'
  include_context "task variables"

  before(:each) do
    login_user(user: mcaro, org_unit: ou1, role: 'Manager')
    visit cards_path
    execute_script("$.support.transition = false")
  end

  describe "visit cards_path" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit cards_path
      execute_script("$.support.transition = false")
    end

    it "shows empty dashboard with accessible ou's and lists" do
      expect(page).to have_css("div#cards_filter")
    end
  end

  describe "visit cards_path(org_unit_id: ou1.id)" do
    before(:each) do
      login_user(user: mcaro, org_unit: ou1, role: 'Manager')
      visit cards_path(org_unit_id: ou1.id)
      execute_script("$.support.transition = false")
    end

    it "shows cardboard with available tasks" do
      within "div#ts_task_cards" do
        expect(page).to have_content("MM task")
        expect(page).to have_content("MM global list task")
      end
    end

    it "open modal task#edit", js: true do
      within "div#card_task_#{to1.id}" do
        # find("a[href='#{edit_task_path(to1)}']").click 
        execute_script("document.querySelector('#edit_task_#{to1.id}').click()")
      end

      find("trix-editor").set("Quark ist kein Käse")
      click_button("Aufgabe aktualisieren")
      to1.reload
      # turbostream needs some time
      sleep 1
      
      expect(to1.description.to_plain_text).to eq("Quark ist kein Käse")

      within "div#card_task_#{to1.id}" do
        expect(page).to have_content("Quark ist kein Käse")
      end
    end

    it "adds a new task", js: true do
      # puts Wobauth::User.all.map{|u| u.to_s}
      within "div#ts_task_cards" do
        expect(all('div.list-group-item').count).to eq(2)
      end
      click_link "new_task_state_#{open.id}"
      within "#modal-body" do
        fill_in "Aufgabe", with: "A new task"
        click_button("Aufgabe erstellen")
      end
      sleep 1
      within "div#ts_task_cards" do
        expect(all('div.list-group-item').count).to eq(3)
        expect(page).to have_content("A new task")
      end
    end

    it "add note to task" do
      expect(to1.notes.count).to eq(0)
      within "div#card_task_#{to1.id}" do
        execute_script("document.querySelector('#new_note_task_#{to1.id}').click()")
      end
      find("trix-editor#note_description").set("Just a simple comment")
      click_button("Notiz erstellen")
      to1.reload

      expect(page).to have_content("Just a simple comment")
      expect(to1.notes.count).to eq(1)
      expect(to1.notes.first.description.to_plain_text).to eq("Just a simple comment")
      within "div#card_task_#{to1.id}" do
        execute_script("document.querySelector('#new_note_task_#{to1.id}').click()")
      end
      within "#modal-body" do
        expect(page).to have_content("Just a simple comment")
      end
    end

    it "add time accounting to task" do
      expect(to1.time_accountings.count).to eq(0)
      within "div#card_task_#{to1.id}" do
        execute_script("document.querySelector('#new_time_accounting_task_#{to1.id}').click()")
      end
      fill_in "Beschreibung", with: "some text"
      fill_in "Dauer (HH:MM)", with: 30
      click_button("Aktivität erstellen")
      to1.reload
      # turbostream needs some time
      sleep 1
      expect(to1.time_accountings.count).to eq(1)
      expect(to1.time_accountings.first.description).to eq("some text")
      expect(to1.time_accountings.first.duration).to eq(30)
    end
  end
end

