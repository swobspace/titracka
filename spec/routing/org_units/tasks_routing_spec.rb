require "rails_helper"

RSpec.describe OrgUnits::TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/org_units/9/tasks").to route_to(controller: 'org_units/tasks', action: "index", org_unit_id: "9")
    end

    it "routes to #new" do
      expect(get: "/org_units/9/tasks/new").to route_to(controller: 'org_units/tasks', action: "new", org_unit_id: "9")
    end

    it "routes to #show" do
      expect(get: "/org_units/9/tasks/1").to route_to(controller: 'org_units/tasks', action: "show", id: "1", org_unit_id: "9")
    end

    it "routes to #edit" do
      expect(get: "/org_units/9/tasks/1/edit").to route_to(controller: 'org_units/tasks', action: "edit", id: "1", org_unit_id: "9")
    end


    it "routes to #create" do
      expect(post: "/org_units/9/tasks").to route_to(controller: 'org_units/tasks', action: "create", org_unit_id: "9")
    end

    it "routes to #update via PUT" do
      expect(put: "/org_units/9/tasks/1").to route_to(controller: 'org_units/tasks', action: "update", id: "1", org_unit_id: "9")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/org_units/9/tasks/1").to route_to(controller: 'org_units/tasks', action: "update", id: "1", org_unit_id: "9")
    end

    it "routes to #destroy" do
      expect(delete: "/org_units/9/tasks/1").to route_to(controller: 'org_units/tasks', action: "destroy", id: "1", org_unit_id: "9")
    end
  end
end
