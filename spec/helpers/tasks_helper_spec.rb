require "rails_helper"
require "cancan/matchers"

RSpec.describe TasksHelper, :type => :helper do
  include Devise::Test::ControllerHelpers
  let(:responsible) { FactoryBot.create(:user, sn: "Mustermann", givenname: "Max") }

  describe "#raci" do
    let(:task) { FactoryBot.create(:task, responsible: responsible) }
    subject { Capybara.string(helper.raci(task)) }
    it "shows responsible enclosed in <span>" do
      expect(subject.find("span.responsible").text).to match("Mustermann, Max")
    end
  end

  describe "#timeline" do
    subject { Capybara.string(helper.timeline(task)) }
    describe "only start set" do
      let(:task) { FactoryBot.create(:task, :open, start: 1.day.before(Date.today)) }
      it { expect(subject.find("span.active").text).to match(1.day.before(Date.today.to_s)) }
    end
  end
end
