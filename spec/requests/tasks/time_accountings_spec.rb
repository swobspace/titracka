 require 'rails_helper'

RSpec.describe "/tasks/:id/time_accountings", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user_id: user.id) }
  let(:workday) { FactoryBot.create(:workday, date: '2020-01-01', user_id: user.id) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:time_accounting, task_id: task.id, user_id: user.id,
                               date: '2020-01-01') 
  }
  let(:post_attributes) {
    FactoryBot.attributes_for(:time_accounting, task_id: task.id,
                               date: '2020-01-01') 
  }

  let(:invalid_attributes) {
    { date: nil, duration: nil }
  }

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      TimeAccounting.create! valid_attributes
      get task_time_accountings_url(task)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      time_accounting = TimeAccounting.create! valid_attributes
      get task_time_accounting_url(task, time_accounting)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_task_time_accounting_url(task)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      time_accounting = TimeAccounting.create! valid_attributes
      get edit_task_time_accounting_url(task, time_accounting)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TimeAccounting" do
        expect {
          post task_time_accountings_url(task), params: { time_accounting: post_attributes }
        }.to change(TimeAccounting, :count).by(1)
      end

      it "redirects to the created time_accounting" do
        post task_time_accountings_url(task), params: { time_accounting: post_attributes }
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TimeAccounting" do
        expect {
          post task_time_accountings_url(task), params: { time_accounting: invalid_attributes }
        }.to change(TimeAccounting, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post task_time_accountings_url(task), params: { time_accounting: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {duration: 123, description: "some other text", date: '2020-04-23' }
      }

      it "updates the requested time_accounting" do
        time_accounting = TimeAccounting.create! valid_attributes
        patch task_time_accounting_url(task, time_accounting), params: { time_accounting: new_attributes }
        time_accounting.reload
        expect(time_accounting.duration).to eq(123)
        expect(time_accounting.description).to eq("some other text")
        expect(time_accounting.date.to_s).to eq("2020-04-23")
      end

      it "redirects to the time_accounting" do
        time_accounting = TimeAccounting.create! valid_attributes
        patch task_time_accounting_url(task, time_accounting), params: { time_accounting: new_attributes }
        time_accounting.reload
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        time_accounting = TimeAccounting.create! valid_attributes
        patch task_time_accounting_url(task, time_accounting), params: { time_accounting: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested time_accounting" do
      time_accounting = TimeAccounting.create! valid_attributes
      expect {
        delete task_time_accounting_url(task, time_accounting)
      }.to change(TimeAccounting, :count).by(-1)
    end

    it "redirects to the time_accountings list" do
      time_accounting = TimeAccounting.create! valid_attributes
      delete task_time_accounting_url(task, time_accounting)
      expect(response).to redirect_to(task_url(task))
    end
  end
end
