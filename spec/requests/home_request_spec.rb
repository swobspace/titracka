require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before(:each) do
    login_user
  end

  describe "GET /index" do
    it "returns http success" do
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
