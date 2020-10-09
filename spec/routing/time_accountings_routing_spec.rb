require "rails_helper"

RSpec.describe TimeAccountingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/time_accountings").to route_to("time_accountings#index")
    end

    it "routes to #new" do
      expect(get: "/time_accountings/new").to route_to("time_accountings#new")
    end

    it "routes to #show" do
      expect(get: "/time_accountings/1").to route_to("time_accountings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/time_accountings/1/edit").to route_to("time_accountings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/time_accountings").to route_to("time_accountings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/time_accountings/1").to route_to("time_accountings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/time_accountings/1").to route_to("time_accountings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/time_accountings/1").to route_to("time_accountings#destroy", id: "1")
    end
  end
end
