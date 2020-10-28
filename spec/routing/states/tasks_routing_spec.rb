require "rails_helper"

RSpec.describe States::TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/states/9/tasks").not_to be_routable
    end

    it "routes to #new" do
      expect(get: "/states/9/tasks/new").to route_to(controller: 'states/tasks', action: "new", state_id: "9")
    end

    it "routes to #show" do
      expect(get: "/states/9/tasks/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(get: "/states/9/tasks/1/edit").to route_to(controller: 'states/tasks', action: "edit", id: "1", state_id: "9")
    end


    it "routes to #create" do
      expect(post: "/states/9/tasks").to route_to(controller: 'states/tasks', action: "create", state_id: "9")
    end

    it "routes to #update via PUT" do
      expect(put: "/states/9/tasks/1").to route_to(controller: 'states/tasks', action: "update", id: "1", state_id: "9")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/states/9/tasks/1").to route_to(controller: 'states/tasks', action: "update", id: "1", state_id: "9")
    end

    it "routes to #destroy" do
      expect(delete: "/states/9/tasks/1").to route_to(controller: 'states/tasks', action: "destroy", id: "1", state_id: "9")
    end
  end
end
