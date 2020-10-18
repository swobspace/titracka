require "rails_helper"

RSpec.describe Workdays::TimeAccountingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/workdays/9/time_accountings").to route_to(controller: 'workdays/time_accountings', action: "index", workday_id: "9")
    end

    it "routes to #new" do
      expect(get: "/workdays/9/time_accountings/new").to route_to(controller: 'workdays/time_accountings', action: "new", workday_id: "9")
    end

    it "routes to #show" do
      expect(get: "/workdays/9/time_accountings/1").to route_to(controller: 'workdays/time_accountings', action: "show", id: "1", workday_id: "9")
    end

    it "routes to #edit" do
      expect(get: "/workdays/9/time_accountings/1/edit").to route_to(controller: 'workdays/time_accountings', action: "edit", id: "1", workday_id: "9")
    end


    it "routes to #create" do
      expect(post: "/workdays/9/time_accountings").to route_to(controller: 'workdays/time_accountings', action: "create", workday_id: "9")
    end

    it "routes to #update via PUT" do
      expect(put: "/workdays/9/time_accountings/1").to route_to(controller: 'workdays/time_accountings', action: "update", id: "1", workday_id: "9")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/workdays/9/time_accountings/1").to route_to(controller: 'workdays/time_accountings', action: "update", id: "1", workday_id: "9")
    end

    it "routes to #destroy" do
      expect(delete: "/workdays/9/time_accountings/1").to route_to(controller: 'workdays/time_accountings', action: "destroy", id: "1", workday_id: "9")
    end
  end
end
