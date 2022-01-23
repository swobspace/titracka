require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  fixtures 'wobauth/roles'
  include_context "task variables"

  before(:each) do
    login_user(user: mcaro, org_unit: ou1, role: 'Manager')
    visit root_path
    execute_script("$.support.transition = false")
  end

  describe "visit root_path", js: true do
    it "shows empty dashboard with accessible ou's and lists" do
      # save_and_open_screenshot()
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Organisationseinheiten / Listen")
      expect(page).to have_content("Mustermann GmbH")
      expect(page).to have_content("Controlling")
      expect(page).to have_content("Mustermanns global list")
      expect(page).to have_content("Private")
    end

    it "shows cardboard with available tasks" do
      click_link "Mustermann GmbH"
      within "div#ts_task_cards" do
        expect(page).to have_content("MM task")
        expect(page).to have_content("MM global list task")
      end
    end

    it "open modal task#edit", js: true do
      click_link "Mustermann GmbH"
      within "div#card_task_#{to1.id}" do
        # find("a[href='#{edit_task_path(to1)}']").click 
        execute_script("document.querySelector('#edit_task_#{to1.id}').click()")
      end

      # sleep 1
      # save_and_open_screenshot()
      # print page.html
      find("trix-editor").set("Quark ist kein Käse")
      click_button("Aufgabe aktualisieren")
      to1.reload
      # turbostream needs some time
      sleep 1
      # save_and_open_screenshot()
      
      expect(to1.description.to_plain_text).to eq("Quark ist kein Käse")

      within "div#card_task_#{to1.id}" do
        expect(page).to have_content("Quark ist kein Käse")
      end
    end

    it "adds a new task" do
      click_link "Mustermann GmbH"
      within "div#ts_task_cards" do
        expect(all('div.list-group-item').count).to eq(2)
      end
      click_link "new_task_state_#{open.id}"
      sleep 1
      fill_in "Aufgabe", with: "A new task"
      within 'div.task_user' do
        find('div.ss-main').click
        find('div.ss-search input').set("Mustermann, Carola (mcaro)")
        find('div.ss-option', text: "Mustermann, Carola (mcaro)").click()
      end   
      click_button("Aufgabe erstellen")
      sleep 1
      within "div#ts_task_cards" do
        expect(all('div.list-group-item').count).to eq(3)
        expect(page).to have_content("A new task")
      end
      # save_and_open_screenshot()
    end

    it "add note to task" do
      expect(to1.notes.count).to eq(0)
      click_link "Mustermann GmbH"
      within "div#card_task_#{to1.id}" do
        execute_script("document.querySelector('#new_note_task_#{to1.id}').click()")
      end
      find("trix-editor#note_description").set("Just a simple comment")
      click_button("Notiz erstellen")
      to1.reload
      # turbostream needs some time
      sleep 1
      expect(to1.notes.count).to eq(1)
      expect(to1.notes.first.description.to_plain_text).to eq("Just a simple comment")
    end

    it "add time accounting to task" do
      expect(to1.time_accountings.count).to eq(0)
      click_link "Mustermann GmbH"
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

