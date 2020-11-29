 require 'rails_helper'

RSpec.describe "/workdays", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:workday, user_id: user.id) 
  }
  let(:post_attributes) {
    FactoryBot.attributes_for(:workday) 
  }

  let(:invalid_attributes) {
    { date: nil }
  }

  before(:each) do
    login_admin(user: user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      Workday.create! valid_attributes
      get workdays_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      workday = Workday.create! valid_attributes
      get workday_url(workday)
      expect(response).to be_successful
    end
  end

  describe "GET /by_date" do
    it "renders a successful response" do
      workday = FactoryBot.create(:workday, date: "2020-02-03", user: user)
      get "/workdays/2020-02-03"
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_workday_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      workday = Workday.create! valid_attributes
      get edit_workday_url(workday)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Workday" do
        expect {
          post workdays_url, params: { workday: post_attributes }
        }.to change(Workday, :count).by(1)
      end

      it "redirects to the created workday" do
        post workdays_url, params: { workday: post_attributes }
        expect(response).to redirect_to(workday_url(Workday.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Workday" do
        expect {
          post workdays_url, params: { workday: invalid_attributes }
        }.to change(Workday, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post workdays_url, params: { workday: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { work_start: '07:00' }
      }

      it "updates the requested workday" do
        workday = Workday.create! valid_attributes
        patch workday_url(workday), params: { workday: new_attributes }
        workday.reload
        expect(workday.work_start.to_s).to match("07:00")
      end

      it "redirects to the workday" do
        workday = Workday.create! valid_attributes
        patch workday_url(workday), params: { workday: new_attributes }
        workday.reload
        expect(response).to redirect_to(workday_url(workday))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        workday = Workday.create! valid_attributes
        patch workday_url(workday), params: { workday: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested workday" do
      workday = Workday.create! valid_attributes
      expect {
        delete workday_url(workday)
      }.to change(Workday, :count).by(-1)
    end

    it "redirects to the workdays list" do
      workday = Workday.create! valid_attributes
      delete workday_url(workday)
      expect(response).to redirect_to(workdays_url)
    end
  end
end
