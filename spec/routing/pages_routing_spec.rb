require "rails_helper"

RSpec.describe PagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pages/index").to route_to("pages#index")
    end

    it "routes to #page" do
      expect(:get => "/pages/about").to route_to("pages#show", "page" => "about")
    end

  end
end

