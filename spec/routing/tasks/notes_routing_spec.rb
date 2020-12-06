require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tasks/99/notes").to route_to(controller: 'tasks/notes', action: "index", task_id: "99")
    end

    it "routes to #new" do
      expect(get: "/tasks/99/notes/new").to route_to(controller: 'tasks/notes', action: "new", task_id: "99")
    end

    it "routes to #show" do
      expect(get: "/tasks/99/notes/1").to route_to(controller: 'tasks/notes', action: "show", task_id: "99", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tasks/99/notes/1/edit").to route_to(controller: 'tasks/notes', action: "edit", task_id: "99", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tasks/99/notes").to route_to(controller: 'tasks/notes', action: "create", task_id: "99")
    end

    it "routes to #update via PUT" do
      expect(put: "/tasks/99/notes/1").to route_to(controller: 'tasks/notes', action: "update", task_id: "99", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tasks/99/notes/1").to route_to(controller: 'tasks/notes', action: "update", task_id: "99", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tasks/99/notes/1").to route_to(controller: 'tasks/notes', action: "destroy", task_id: "99", id: "1")
    end
  end
end
