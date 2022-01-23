 require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  let!(:state) { FactoryBot.create(:state) }
  let(:user) { FactoryBot.create(:user) }
  let(:open) { FactoryBot.create(:state, :open) }
  let(:ou)   { FactoryBot.create(:org_unit) }
  let(:reference) { FactoryBot.create(:reference) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:task, user_id: user.id, state_id: open.id, 
                                     org_unit_id: ou.id)
  }

  let(:invalid_attributes) {
    { subject: nil, state_id: nil, priority: 'wrong' }
  }

  before(:each) do
    login_admin(user: user)
    allow_any_instance_of(Ability).to receive_message_chain(:rights, :manager, :org_units).and_return([ou.id])
  end

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url
      expect(response).to be_successful
    end
  end

  describe "GET /index?view=cards" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url(view: 'cards')
      expect(response).to be_successful
    end
  end

  describe "GET /index?org_unit_id=ou.id" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url(org_unit_id: ou.to_param)
      expect(response).to be_successful
    end
  end

  describe "GET /search_form" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get search_form_tasks_url
      expect(response).to be_successful
    end
  end

  describe "GET /query" do
    it "renders a successful response" do
      workday = FactoryBot.create(:workday, user: user)
      FactoryBot.create(:task, user_id: user.id, state_id: open.id, 
                         subject: "Secret Stuff", org_unit_id: ou.id)
      get query_tasks_url(subject: "Secret", workday_id: workday.id, 
                          format: :turbo_stream)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get task_url(task)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_task_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      task = Task.create! valid_attributes
      get edit_task_url(task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_url, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post tasks_url, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_url, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post tasks_url, params: { task: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{
        subject: "new subject", 
        priority: "high" , 
        description: "some text",
        cross_references_attributes: [
          reference_id: reference.id,
          identifier: "1234321"
        ]
      }}

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(task.subject).to eq("new subject")
        expect(task.priority).to eq("high")
        expect(task.description.to_s).to eq("<div class=\"trix-content\">\n  some text\n</div>\n")
        expect(task.cross_references.first.reference_id).to eq(reference.id)
        expect(task.cross_references.first.identifier).to eq("1234321")
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete task_url(task)
      expect(response).to redirect_to(tasks_url)
    end
  end
end
