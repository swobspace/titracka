require "rails_helper"
require "cancan/matchers"

RSpec.describe TasksHelper, :type => :helper do
  include Devise::Test::ControllerHelpers
  let(:responsible) { FactoryBot.create(:user, sn: "Mustermann", givenname: "Max") }
  let(:task) { FactoryBot.create(:task, responsible: responsible) }

  describe "#raci" do
    subject { Capybara.string(helper.raci(task)) }
    it "shows responsible enclosed in <span>" do
      expect(subject.find("span.responsible").text).to match("Mustermann, Max")
    end
  end
end
