require "rails_helper"

RSpec.describe TimeAccountingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/time_accountings").to route_to("time_accountings#index")
    end

    it "routes to #index (:post)" do
      expect(:post => "time_accountings.json").to route_to(controller: 'time_accountings', action: "index", format: "json")
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

    it "routes to #search_form" do
      expect(:get => "/time_accountings/search_form").to route_to("time_accountings#search_form")
    end

    it "routes to #search" do
      expect(:get => "/time_accountings/search").to route_to("time_accountings#search")
    end

    it "routes to #search" do
      expect(:post => "/time_accountings/search").to route_to("time_accountings#search")
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
