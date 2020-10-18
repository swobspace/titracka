require "rails_helper"

RSpec.describe "root", type: :routing do
  describe "routing" do
    it "routes to #by_date" do
      expect(get: "/2020-02-03").to route_to("workdays#by_date", date: "2020-02-03")
    end
  end
end
