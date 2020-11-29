 require 'rails_helper'

RSpec.describe "/lists/:id/tasks", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:list) { FactoryBot.create(:list, user_id: user.id) }
  let(:open) { FactoryBot.create(:state, :open) }
  let(:ou)   { FactoryBot.create(:org_unit) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:task, list_id: list.id, user_id: user.id,
                              state_id: open.id, org_unit_id: ou.id)
  }
  let(:post_attributes) {
    FactoryBot.attributes_for(:task, list_id: list.id,
                              state_id: open.id, org_unit_id: ou.id)
  }

  let(:invalid_attributes) {
    { state_id: nil, subject: nil }
  }

  before(:each) do
    login_admin(user: user)
    allow_any_instance_of(Ability).to receive_message_chain(:rights, :manager, :org_units).and_return([ou.id])
  end

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get list_tasks_url(list)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get list_task_url(list, task)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_list_task_url(list)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      task = Task.create! valid_attributes
      get edit_list_task_url(list, task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post list_tasks_url(list), params: { task: post_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post list_tasks_url(list), params: { task: post_attributes }
        expect(response).to redirect_to(list_url(list))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post list_tasks_url(list), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post list_tasks_url(list), params: { task: invalid_attributes }
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
        patch list_task_url(list, task), params: { task: new_attributes }
        task.reload
        expect(task.priority).to eq('high')
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        patch list_task_url(list, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(list_url(list))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch list_task_url(list, task), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete list_task_url(list, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete list_task_url(list, task)
      expect(response).to redirect_to(list_url(list))
    end
  end
end
