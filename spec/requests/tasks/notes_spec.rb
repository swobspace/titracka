 require 'rails_helper'

RSpec.describe "/tasks/:id/notes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user_id: user.id) }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:note, task_id: task.id, user_id: user.id)
  }
  let(:post_attributes) {
    FactoryBot.attributes_for(:note, task_id: task.id)
  }

  let(:invalid_attributes) {
    { description: nil }
  }

  before(:each) do
    login_admin
  end


  describe "GET /index" do
    it "renders a successful response" do
      Note.create! valid_attributes
      get task_notes_url(task)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get task_note_url(task, note)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_task_note_url(task)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      note = Note.create! valid_attributes
      get edit_task_note_url(task, note)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Note" do
        expect {
          post task_notes_url(task), params: { note: post_attributes }
        }.to change(Note, :count).by(1)
      end

      it "redirects to the created note" do
        post task_notes_url(task), params: { note: post_attributes }
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Note" do
        expect {
          post task_notes_url(task), params: { note: invalid_attributes }
        }.to change(Note, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post task_notes_url(task), params: { note: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{ 
        date: '2019-01-01' ,
        description: "rich description"
      }}

      it "updates the requested note" do
        note = Note.create! valid_attributes
        patch task_note_url(task, note), params: { note: new_attributes }
        note.reload
        expect(note.date.to_s).to eq(Date.today.to_s)
        expect(note.description.to_plain_text).to eq("rich description")
      end

      it "redirects to the note" do
        note = Note.create! valid_attributes
        patch task_note_url(task, note), params: { note: new_attributes }
        note.reload
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        note = Note.create! valid_attributes
        patch task_note_url(task, note), params: { note: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested note" do
      note = Note.create! valid_attributes
      expect {
        delete task_note_url(task, note)
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      note = Note.create! valid_attributes
      delete task_note_url(task, note)
      expect(response).to redirect_to(task_url(task))
    end
  end
end
