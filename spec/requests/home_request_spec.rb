require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:ou)   { FactoryBot.create(:org_unit) }
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    login_user(user: user)
    allow_any_instance_of(Ability).to receive_message_chain(:rights, :manager, :org_units).and_return([ou.id])
  end

  describe "GET /index" do
    it "returns http success" do
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
