require "rails_helper"

RSpec.describe DayTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/day_types").to route_to("day_types#index")
    end

    it "routes to #new" do
      expect(get: "/day_types/new").to route_to("day_types#new")
    end

    it "routes to #show" do
      expect(get: "/day_types/1").to route_to("day_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/day_types/1/edit").to route_to("day_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/day_types").to route_to("day_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/day_types/1").to route_to("day_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/day_types/1").to route_to("day_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/day_types/1").to route_to("day_types#destroy", id: "1")
    end
  end
end
