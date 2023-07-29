require "rails_helper"

RSpec.describe WorkdaysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/workdays").to route_to("workdays#index")
    end

    it "routes to #calendar" do
      expect(get: "/workdays/calendar").to route_to("workdays#calendar")
    end
    it "routes to #new" do
      expect(get: "/workdays/new").to route_to("workdays#new")
    end

    it "routes to #show" do
      expect(get: "/workdays/1").to route_to("workdays#show", id: "1")
    end

    it "routes to #by_date" do
      expect(get: "/workdays/2020-02-03").to route_to("workdays#by_date", date: "2020-02-03")
    end

    it "routes to #edit" do
      expect(get: "/workdays/1/edit").to route_to("workdays#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/workdays").to route_to("workdays#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/workdays/1").to route_to("workdays#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/workdays/1").to route_to("workdays#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/workdays/1").to route_to("workdays#destroy", id: "1")
    end
  end
end
