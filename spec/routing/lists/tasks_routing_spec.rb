require "rails_helper"

RSpec.describe Lists::TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/lists/9/tasks").to route_to(controller: 'lists/tasks', action: "index", list_id: "9")
    end

    it "routes to #new" do
      expect(get: "/lists/9/tasks/new").to route_to(controller: 'lists/tasks', action: "new", list_id: "9")
    end

    it "routes to #show" do
      expect(get: "/lists/9/tasks/1").to route_to(controller: 'lists/tasks', action: "show", id: "1", list_id: "9")
    end

    it "routes to #edit" do
      expect(get: "/lists/9/tasks/1/edit").to route_to(controller: 'lists/tasks', action: "edit", id: "1", list_id: "9")
    end


    it "routes to #create" do
      expect(post: "/lists/9/tasks").to route_to(controller: 'lists/tasks', action: "create", list_id: "9")
    end

    it "routes to #update via PUT" do
      expect(put: "/lists/9/tasks/1").to route_to(controller: 'lists/tasks', action: "update", id: "1", list_id: "9")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lists/9/tasks/1").to route_to(controller: 'lists/tasks', action: "update", id: "1", list_id: "9")
    end

    it "routes to #destroy" do
      expect(delete: "/lists/9/tasks/1").to route_to(controller: 'lists/tasks', action: "destroy", id: "1", list_id: "9")
    end
  end
end
