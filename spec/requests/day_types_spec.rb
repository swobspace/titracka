require 'rails_helper'

RSpec.describe "/day_types", type: :request do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:day_type)
  }

  let(:invalid_attributes) {
    { abbrev: nil }
  }

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      DayType.create! valid_attributes
      get day_types_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      day_type = DayType.create! valid_attributes
      get day_type_url(day_type)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_day_type_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      day_type = DayType.create! valid_attributes
      get edit_day_type_url(day_type)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new DayType" do
        expect {
          post day_types_url, params: { day_type: valid_attributes }
        }.to change(DayType, :count).by(1)
      end

      it "redirects to the created day_type" do
        post day_types_url, params: { day_type: valid_attributes }
        expect(response).to redirect_to(day_type_url(DayType.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new DayType" do
        expect {
          post day_types_url, params: { day_type: invalid_attributes }
        }.to change(DayType, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post day_types_url, params: { day_type: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { description: "brabbelfasel" }
      }

      it "updates the requested day_type" do
        day_type = DayType.create! valid_attributes
        patch day_type_url(day_type), params: { day_type: new_attributes }
        day_type.reload
        expect(day_type.description).to eq("brabbelfasel")
      end

      it "redirects to the day_type" do
        day_type = DayType.create! valid_attributes
        patch day_type_url(day_type), params: { day_type: new_attributes }
        day_type.reload
        expect(response).to redirect_to(day_type_url(day_type))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        day_type = DayType.create! valid_attributes
        patch day_type_url(day_type), params: { day_type: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested day_type" do
      day_type = DayType.create! valid_attributes
      expect {
        delete day_type_url(day_type)
      }.to change(DayType, :count).by(-1)
    end

    it "redirects to the day_types list" do
      day_type = DayType.create! valid_attributes
      delete day_type_url(day_type)
      expect(response).to redirect_to(day_types_url)
    end
  end
end
