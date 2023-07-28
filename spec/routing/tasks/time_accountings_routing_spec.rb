require "rails_helper"

RSpec.describe Tasks::TimeAccountingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tasks/9/time_accountings").to route_to(controller: 'tasks/time_accountings', action: "index", task_id: "9")
    end

    it "routes to #index (:post)" do
      expect(:post => "/tasks/9/time_accountings.json").to route_to(controller: 'tasks/time_accountings', action: "index", format: "json", task_id: "9")
    end

    it "routes to #new" do
      expect(get: "/tasks/9/time_accountings/new").to route_to(controller: 'tasks/time_accountings', action: "new", task_id: "9")
    end

    it "routes to #show" do
      expect(get: "/tasks/9/time_accountings/1").to route_to(controller: 'tasks/time_accountings', action: "show", id: "1", task_id: "9")
    end

    it "routes to #edit" do
      expect(get: "/tasks/9/time_accountings/1/edit").to route_to(controller: 'tasks/time_accountings', action: "edit", id: "1", task_id: "9")
    end


    it "routes to #create" do
      expect(post: "/tasks/9/time_accountings").to route_to(controller: 'tasks/time_accountings', action: "create", task_id: "9")
    end

    it "routes to #update via PUT" do
      expect(put: "/tasks/9/time_accountings/1").to route_to(controller: 'tasks/time_accountings', action: "update", id: "1", task_id: "9")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tasks/9/time_accountings/1").to route_to(controller: 'tasks/time_accountings', action: "update", id: "1", task_id: "9")
    end

    it "routes to #destroy" do
      expect(delete: "/tasks/9/time_accountings/1").to route_to(controller: 'tasks/time_accountings', action: "destroy", id: "1", task_id: "9")
    end
  end
end
