 require 'rails_helper'

RSpec.describe "/org_units", type: :request do
  let!(:state) { FactoryBot.create(:state) }
  let(:parent) { FactoryBot.create(:org_unit) }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:org_unit)
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      OrgUnit.create! valid_attributes
      get org_units_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      org_unit = OrgUnit.create! valid_attributes
      get org_unit_url(org_unit)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_org_unit_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      org_unit = OrgUnit.create! valid_attributes
      get edit_org_unit_url(org_unit)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new OrgUnit" do
        expect {
          post org_units_url, params: { org_unit: valid_attributes }
        }.to change(OrgUnit, :count).by(1)
      end

      it "redirects to the created org_unit" do
        post org_units_url, params: { org_unit: valid_attributes }
        expect(response).to redirect_to(org_unit_url(OrgUnit.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new OrgUnit" do
        expect {
          post org_units_url, params: { org_unit: invalid_attributes }
        }.to change(OrgUnit, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post org_units_url, params: { org_unit: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          name: "Nobody Ltd.",
          parent_id: parent.id,
          description: "some blafasel",
          valid_until: '2099-12-21',
        }
      end

      it "updates the requested org_unit" do
        org_unit = OrgUnit.create! valid_attributes
        patch org_unit_url(org_unit), params: { org_unit: new_attributes }
        org_unit.reload
        expect(org_unit.name).to eq("Nobody Ltd.")
        expect(org_unit.description.to_plain_text).to eq("some blafasel")
        expect(org_unit.valid_until.to_s).to eq("2099-12-21")
      end

      it "redirects to the org_unit" do
        org_unit = OrgUnit.create! valid_attributes
        patch org_unit_url(org_unit), params: { org_unit: new_attributes }
        org_unit.reload
        expect(response).to redirect_to(org_unit_url(org_unit))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        org_unit = OrgUnit.create! valid_attributes
        patch org_unit_url(org_unit), params: { org_unit: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested org_unit" do
      org_unit = OrgUnit.create! valid_attributes
      expect {
        delete org_unit_url(org_unit)
      }.to change(OrgUnit, :count).by(-1)
    end

    it "redirects to the org_units list" do
      org_unit = OrgUnit.create! valid_attributes
      delete org_unit_url(org_unit)
      expect(response).to redirect_to(org_units_url)
    end
  end
end
