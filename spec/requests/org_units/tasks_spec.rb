 require 'rails_helper'

RSpec.describe "/org_units/:id/tasks", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:open) { FactoryBot.create(:state, :open) }
  let(:org_unit)   { FactoryBot.create(:org_unit) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:task, org_unit_id: org_unit.id, user_id: user.id,
                              state_id: open.id)
  }

  let(:invalid_attributes) {
    { state_id: nil, subject: nil }
  }

  before(:each) do
    login_admin(user: user)
    allow_any_instance_of(Ability).to receive_message_chain(:rights, :manager, :org_units).and_return([org_unit.id])
  end

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get org_unit_tasks_url(org_unit)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get org_unit_task_url(org_unit, task)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_org_unit_task_url(org_unit)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      task = Task.create! valid_attributes
      get edit_org_unit_task_url(org_unit, task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post org_unit_tasks_url(org_unit), params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post org_unit_tasks_url(org_unit), params: { task: valid_attributes }
        expect(response).to redirect_to(org_unit_url(org_unit))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post org_unit_tasks_url(org_unit), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post org_unit_tasks_url(org_unit), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {priority: 'high'}
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch org_unit_task_url(org_unit, task), params: { task: new_attributes }
        task.reload
        expect(task.priority).to eq('high')
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        patch org_unit_task_url(org_unit, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(org_unit_url(org_unit))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch org_unit_task_url(org_unit, task), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete org_unit_task_url(org_unit, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks org_unit" do
      task = Task.create! valid_attributes
      delete org_unit_task_url(org_unit, task)
      expect(response).to redirect_to(org_unit_url(org_unit))
    end
  end
end
